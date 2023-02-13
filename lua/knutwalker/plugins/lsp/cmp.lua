local M = {}

function M.setup(lsp)
	-- setup completions
	local has_words_before = function()
		-- local unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local cmp = require("cmp")
	local snip = require("luasnip")
	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	local cmp_mappings = lsp.defaults.cmp_mappings({
		-- Select previous item
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		-- Select next items
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		-- Insert selected item
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		-- Replace with selected item
		["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
		-- Open usggestions
		["<C-space>"] = cmp.mapping.complete(),
		-- Close suggestions, in all modes
		["<C-e>"] = cmp.mapping.close(),
		-- Close suggestions, only in insert mode
		["<ESC>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.close()
			else
				fallback()
			end
		end, { "i" }),
		-- Tab selects the next placeholder, the next item, expands the snippet, or calls the fallback
		["<Tab>"] = cmp.mapping(function(fallback)
			if snip.jumpable(1) then
				snip.jump(1)
			elseif cmp.visible() then
				cmp.select_next_item()
			elseif snip.expandable() then
				snip.expand()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		-- Shift-Tab selects the previous placeholder, the previous item, or calls the fallback
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if snip.jumpable(-1) then
				snip.jump(-1)
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	})

	-- If you want insert `(` after select function or method item
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

	-- Load some vscode snippets
	local snippets_path = vim.fn.stdpath("data") .. "/vscode_snippets/"
	-- require("luasnip.util.log").set_loglevel("info")
	require("luasnip.loaders.from_vscode").load({
		paths = {
			snippets_path .. "trusty_rusty_snippets",
			snippets_path .. "bevy-snippets",
		},
	})

	-- Actually setup completions
	local types = require("cmp.types")
	local kinds = types.lsp.CompletionItemKind
	local kind_mapping = {
		[kinds.Variable] = 1,
		[kinds.Method] = 1,
		[kinds.Function] = 1,
		[kinds.Field] = 1,
		[kinds.Property] = 1,
		[kinds.EnumMember] = 1,
		[kinds.Constant] = 1,
		[kinds.Constructor] = 1,
		[kinds.Class] = 1,
		[kinds.Enum] = 1,
		[kinds.Struct] = 1,
		[kinds.Interface] = 1,
		[kinds.TypeParameter] = 1,
		[kinds.Module] = 1,
		[kinds.Keyword] = 1,
		[kinds.Unit] = 1,
		[kinds.Value] = 1,
		[kinds.Color] = 2,
		[kinds.File] = 2,
		[kinds.Reference] = 2,
		[kinds.Folder] = 2,
		[kinds.Event] = 2,
		[kinds.Operator] = 2,
		[kinds.Snippet] = 24,
		[kinds.Text] = 25,
	}
	lsp.setup_nvim_cmp({
		mapping = cmp_mappings,
		-- Do not preselect an item from the completions
		preselect = "none",
		-- matches what is configured in set.lua
		completion = {
			autocomplete = false,
			completeopt = "menu,menuone,noinsert,noselect,preview",
		},
		-- configure the LSP as expansion engine, this should be set by LSP-zero as well
		snippet = {
			expand = function(args)
				snip.lsp_expand(args.body)
			end,
		},
		-- reformat the completion items with lsp_kind
		formatting = {
			format = require("lspkind").cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "…",
				preset = "default",
				menu = {
					nvim_lsp = "[lsp]",
					nvim_lua = "[lua]",
					luasnip = "[snip]",
					crates = "[crates]",
					emoji = "[🙈]",
					git = "[git]",
					path = "[path]",
					buffer = "[buf]",
					Copilot = "[copilot]",
				},
			}),
		},

		-- Try to modify the order of suggested items
		sorting = {
			priority_weight = 2,
			comparators = {

				cmp.config.compare.exact,

				-- derank copilot entries
				-- this is the inverse of
				-- require("copilot_cmp.comparators").prioritize,
				function(entry1, entry2)
					if entry1.copilot and not entry2.copilot then
						return false
					elseif entry2.copilot and not entry1.copilot then
						return true
					end
				end,
				require("copilot_cmp.comparators").score,

				cmp.config.compare.locality,
				cmp.config.compare.recently_used,
				cmp.config.compare.sort_text,

				function(entry1, entry2)
					local kind1 = kind_mapping[entry1:get_kind()]
					local kind2 = kind_mapping[entry2:get_kind()]
					local diff = kind1 - kind2
					if diff < 0 then
						return true
					elseif diff > 0 then
						return false
					end
				end,

				cmp.config.compare.score,
				cmp.config.compare.offset,
				cmp.config.compare.order,
			},
		},

		-- setup completion sources
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "crates" },
			{ name = "emoji" },
			{ name = "git" },
			{ name = "path" },
			{ name = "copilot" },
		}, {
			{ name = "buffer", keyword_length = 5 },
		}),

		view = { entries = { name = "custom", selection_order = "near_cursor" } },
	})
end

return M

local M = {}

function M.setup(lsp_opts)
	lsp_opts.settings = {
		["rust-analyzer"] = {
			assist = {
				emitMustUse = true,
			},
			cachePriming = { numThreads = 4 },
			checkOnSave = { command = "clippy" },
			completion = { callable = { snippets = "add_parentheses" }, privateEditable = { enable = true } },
			diagnostics = { disabled = { "inactive-code" } },
			files = { excludeDirs = { "references" } },
			hover = {
				actions = {
					debug = { enable = true },
					enable = true,
					gotoTypeDef = { enable = true },
					implementations = { enable = true },
					run = { enable = true },
				},
				documentation = {
					enable = true,
					keywords = { enable = true },
				},
				links = { enable = true },
			},
			imports = { prefix = "crate" },
			inlayHints = {
				bindingModeHints = { enable = true },
				closureReturnTypeHints = { enable = "always" },
				expressionAdjustmentHints = { enable = "reborrow" },
				lifetimeElisionHints = { enable = "skip_trivial", useParameterNames = true },
				maxLength = 42,
			},
			lens = { references = { method = { enable = true }, trait = { enable = true } } },
			procMacro = { attributes = { enable = true }, enable = true },
		},
	}

	local codelldb_extension = vim.fn.stdpath("data") .. "/codelldb/extension/"
	local codelldb_path = codelldb_extension .. "adapter/codelldb"
	local liblldb_path = codelldb_extension .. "lldb/lib/liblldb.dylib"

	require("rust-tools").setup({
		server = lsp_opts,
		tools = {
			inlay_hints = {
				auto = false,
				only_current_line = false,
			},
			hover_actions = {
				auto_focus = true,
			},
			crate_graph = {
				backend = "dot",
			},
		},
		dap = {
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	})
end

function M.attach(bind)
	local rt = require("rust-tools")

	bind("<leader>R<CR>", rt.code_action_group.code_action_group, "[R]ust Code Action", { "n", "x", "v" })
	bind([[<leader>\]], rt.hover_actions.hover_actions, "RA Hover Action", { "n", "x", "v" })
	bind("<leader>k", rt.hover_actions.hover_actions, "RA: Hover Action", { "n", "x", "v" })

	local hints_on = false
	local function toggle_hints()
		local enable = not hints_on
		hints_on = enable
		vim.notify("Inlay hints have been " .. (enable and "enabled" or "disabled"))
		if enable then
			rt.inlay_hints.set()
		else
			rt.inlay_hints.unset()
		end
	end

	bind("<leader>h", toggle_hints, "RA: Toggle inlay [h]ints", { "n", "v" })
	bind("<M-h>", toggle_hints, "RA: Toggle inlay [h]ints", "i")

	bind("<leader>Rhs", rt.inlay_hints.set, "[R]ust inlay [h]ints [s]et")
	bind("<leader>Rhu", rt.inlay_hints.unset, "[R]ust inlay [h]ints [u]nset")
	bind("<leader>Rhe", rt.inlay_hints.enable, "[R]ust inlay [h]ints [e]nable")
	bind("<leader>Rhd", rt.inlay_hints.disable, "[R]ust inlay [h]ints [d]isable")

	bind("<leader>Rr", rt.runnables.runnables, "[R]ust [r]unnables")
	bind("<leader>Re", rt.expand_macro.expand_macro, "[R]ust [e]xpand macro")

	bind("<leader>Rj", function()
		rt.move_item.move_item(false)
	end, "[R]ust Move item down")
	bind("<leader>Rk", function()
		rt.move_item.move_item(true)
	end, "[R]ust Move item up")

	bind("<leader>Rha", rt.hover_actions.hover_actions, "[R]ust [h]over [a]ctions")
	bind("<leader>Rhr", rt.hover_range.hover_range, "[R]ust [h]over [r]ange")

	bind("<leader>Rc", rt.open_cargo_toml.open_cargo_toml, "[R]ust [c]argo toml")
	bind("<leader>Rp", rt.parent_module.parent_module, "[R]ust [p]arent module")

	bind("<leader>RJ", rt.join_lines.join_lines, "[R]ust [J]oin lines")

	bind("<leader>Rs", function()
		rt.ssr.ssr(vim.fn.input("SSR > "))
	end, "[R]ust [s]tructural search/replace")

	bind("<leader>RC", rt.crate_graph.view_crate_graph, "[R]ust [C]rate graph")
end

return M

local M = {}

function M.setup()
	-- Setup LSP keymap when attached to an LSP
	-- If rust-analyzer attaches, we use the rust-tools provided actions
	local telescope = require("telescope.builtin")
	local buf = vim.lsp.buf
	local cl = vim.lsp.codelens

	local function on_attach(client, bufnr)
		local bind = function(keys, func, desc, mode)
			if desc then
				desc = "LSP: " .. desc
			end
			if not mode then
				mode = "n"
			end

			vim.keymap.set(mode, keys, func, { buffer = bufnr, remap = false, desc = desc })
		end

		bind("<leader>li", "<cmd>LspInfo<CR>", "Information")
		bind("<leader>lI", "<cmd>NullLsInfo<CR>", "Null-LS Information")

		if client.name == "jdtls" then
			require("knutwalker.plugins.lsp.java").attach(bind)
		end

		if client.name == "rust_analyzer" then
			require("knutwalker.plugins.lsp.rust").attach(bind)
		end

		local capabilities = client.server_capabilities

		bind("<leader><CR>", buf.code_action, "Code Action", { "n", "x", "v" })
		bind("<M-Return>", buf.code_action, "Code Action", { "n", "x", "v" })
		bind("<M-Return>", "<C-o>:lua vim.lsp.buf.code_action()<CR>", "Code Action", { "i" })

		bind("<leader>lc", cl.run, "Run Code Lens")
		bind("<leader>lR", cl.refresh, "Refresh Code Lens")

		bind("gl", buf.declaration, "[G]o to dec[l]aration")

		bind("gd", telescope.lsp_definitions, "[G]o to [d]efinition")
		bind("gD", "<CMD>TroubleToggle lsp_definitions<CR>", "[G]o to [D]efinition in Trouble")
		bind("<leader>fd", telescope.lsp_definitions, "[F]ind [d]efinitions")

		bind("<leader>s", telescope.lsp_document_symbols, "Search [s]ymbols in this file")

		bind("K", buf.hover, "Hover symbol")
		bind("<M-k>", buf.hover, "Hover symbol", "i")
		if client.name ~= "rust_analyzer" then
			bind("<leader>k", buf.hover, "Hover symbol")
		end

		bind("gi", telescope.lsp_implementations, "[G]o to [i]mplementation")

		bind("gr", telescope.lsp_references, "[G]o to [r]eferences")
		bind("gR", "<CMD>TroubleToggle lsp_references<CR>", "[G]o to [R]eferences in Trouble")

		vim.keymap.set("n", "<leader>rr", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, { expr = true, desc = "LSP: [R]ename under cursor" })
		bind("<leader>rn", ":IncRename ", "[R]e[n]ame to")
		bind("<leader>rR", buf.rename, "[R]ename (non-incremental)")

		bind("<leader>H", buf.signature_help, "Signature [H]elp")
		bind("<C-h>", buf.signature_help, "Signature [H]elp", "i")

		bind("gy", telescope.lsp_type_definitions, "[G]o to t[y]pe definition")
		bind("gY", "<CMD>TroubleToggle lsp_type_definitions<CR>", "[G]o to t[y]pe definition in Trouble")
		bind("<leader>fy", telescope.lsp_type_definitions, "[F]ind t[y]pe definitions")

		bind("<leader>S", telescope.lsp_dynamic_workspace_symbols, "Search [S]ymbols in this workspace")
		bind("<leader>fs", telescope.lsp_workspace_symbols, "Search [S]ymbols in this workspace (once)")

		if capabilities.documentFormattingProvider then
			local function fmt_filter(fmt_client)
				--  only use null-ls for formatting instead of lsp server
				return fmt_client.name == "null-ls"
					or fmt_client.name == "rustfmt"
					or fmt_client.name == "rust_analyzer"
			end

			local fmt_opts = {
				format_on_save = { enabled = true },
				disabled = {},
				filter = fmt_filter,
				bufnr = bufnr,
			}

			local function format()
				buf.format(fmt_opts)
			end

			vim.api.nvim_buf_create_user_command(bufnr, "Format", format, { desc = "Format file with LSP" })

			bind("<leader>fm", format, "[F]or[m]at")
			bind("<leader>fm", format, "[F]or[m]at", "v")

			bind("<leader>fM", function()
				vim.g.autoformat_disabled = not vim.g.autoformat_disabled
				print("Autoformat: " .. vim.inspect(not vim.g.autoformat_disabled))
			end, "Toggle [F]or[m]at on save")

			local auto_group = "lsp_auto_format_" .. bufnr
			vim.api.nvim_create_augroup(auto_group, { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				desc = "Auto format buffer " .. bufnr .. " before save",
				group = auto_group,
				buffer = bufnr,
				callback = function()
					if not vim.g.autoformat_disabled then
						buf.format(fmt_opts)
					end
				end,
			})
		end

		if capabilities.documentHighlightProvider then
			local highlight_name = "lsp_document_highlight_" .. bufnr
			vim.api.nvim_create_augroup(highlight_name, {})
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = highlight_name,
				buffer = bufnr,
				callback = buf.document_highlight,
			})
			vim.api.nvim_create_autocmd("CursorMoved", {
				group = highlight_name,
				buffer = bufnr,
				callback = buf.clear_references,
			})
		end

		if capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
		end
	end

	return on_attach
end

return M

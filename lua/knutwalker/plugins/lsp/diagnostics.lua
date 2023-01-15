local M = {}

function M.setup_before_lsp()
	-- Setup diagnostic keymaps
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
	vim.keymap.set("n", "<leader>[", vim.diagnostic.open_float, { desc = "Show diagnostic" })
	vim.keymap.set("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "Set diagnostic to loclist" })

	-- Setup diagnostics
	vim.diagnostic.config({
		-- Sort diagnostics by severity
		severity_sort = true,
		-- Show diagnostics in the sign column
		signs = true,
		-- Update diagnostics live while typing
		-- if false, diagnostics are only updated on InsertLeave
		update_in_insert = true,
		-- Single line diagnostics at the end
		virtual_text = false,
		-- multi line diagnostics in between
		virtual_lines = false,
	})

	-- Toggle between multiline and single line diagnostics
	local function toggle_lsp_lines()
		local config = vim.diagnostic.config()
		local flag = config.virtual_text
		vim.diagnostic.config({ virtual_lines = flag, virtual_text = not flag })
	end
	vim.keymap.set("n", "<leader>]", toggle_lsp_lines, { desc = "Toggle LSP line diagnostics" })
	vim.keymap.set("i", "<M-d>", toggle_lsp_lines, { desc = "Toggle LSP line diagnostics" })

	-- Toggle between diagnostics on and off
	local function toggle_lsp_diagnostics()
		local config = vim.diagnostic.config()
		local flag = config.virtual_text or config.virtual_lines
		vim.diagnostic.config({ virtual_lines = false, virtual_text = not flag })
	end
	vim.keymap.set("n", "<leader>}", toggle_lsp_diagnostics, { desc = "Toggle LSP diagnostics" })
	vim.keymap.set("i", "<M-S-d>", toggle_lsp_diagnostics, { desc = "Toggle LSP diagnostics" })
end

function M.setup_after_lsp()
	-- Readme says to setup lsp-lines after lspconfig
	require("lsp_lines").setup()
end

return M

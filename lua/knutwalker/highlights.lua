local M = {}

function M.setup()
	vim.api.nvim_set_hl(0, "TreesitterContext", { link = "Normal" })
end

return M

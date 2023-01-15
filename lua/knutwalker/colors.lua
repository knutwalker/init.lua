local M = {}

M.default_color_scheme = "onedark_vivid"

function M.set(color)
	color = color or M.default_color_scheme
	vim.cmd.colorscheme(color)
end

return M

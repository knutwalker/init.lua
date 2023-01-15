local M = {}

M.default_color_scheme = "tokyonight-moon"

function M.set(color)
	color = color or M.default_color_scheme
	vim.cmd.colorscheme(color)
end

return M

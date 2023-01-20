local M = {}

M.default_color_scheme = "tokyonight-moon"
M.default_color_scheme_light = "tokyonight-day"

function M.set(color)
	vim.cmd.colorscheme(color or M.default_color_scheme)
end

function M.set_dark(color)
	vim.opt.background = "dark"
	M.set(color or M.default_color_scheme)
end

function M.set_light(color)
	vim.opt.background = "light"
	M.set(color or M.default_color_scheme_light)
end

function M.toggle()
	local current_background = vim.o.background
	if current_background ~= "light" then
		M.set_light()
		vim.notify("Changed background to 'light'")
	else
		M.set_dark()
		vim.notify("Changed background to 'dark'")
	end
end

return M

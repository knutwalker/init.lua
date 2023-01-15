-- bootstrap from github
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"git@github.com:folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local default_color_scheme = "onedark_vivid"
function ColorMyPencils(color)
	color = color or default_color_scheme
	vim.cmd.colorscheme(color)
end

-- load lazy
require("lazy").setup("knutwalker.plugins", {
	defaults = { lazy = false },
	install = { colorscheme = { default_color_scheme } },
	checker = {
		-- do not automatically check for plugin updates
		enabled = false,
	},
	change_detection = {
		-- Don't notify when changes are found
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
			},
		},
	},
})
vim.keymap.set("n", "<leader>lz", "<cmd>:Lazy<cr>")

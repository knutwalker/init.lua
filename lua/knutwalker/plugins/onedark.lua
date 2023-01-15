-- One dark colorscheme
return {
	"olimorris/onedarkpro.nvim",
	lazy = true,
	priority = 1000,
	config = function()
		require("onedarkpro").setup({
			options = {
				cursorline = true, -- Use cursorline highlighting?
				transparency = false, -- Use a transparent background?
				terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
				highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
			},
		})
		require("knutwalker.colors").set()
	end,
}

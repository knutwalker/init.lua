return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	keys = require("knutwalker.keymap").zen_mode(),
	opts = {
		window = {
			width = 0.60,
			options = {
				number = true,
				relativenumber = true,
			},
		},
		plugins = {
			gitsigns = true,
			tmux = true,
			alacritty = { enabled = true, font = "18" },
		},
	},
}

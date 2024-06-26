return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = false,
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = { "MunifTanjim/nui.nvim" },
	keys = require("knutwalker.keymap").neotree(),
	init = function()
		-- Unless you are still migrating, remove the deprecated commands from v1.x
		vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
	end,
	opts = {
		close_if_last_window = true,
		sort_case_insensitive = true,
		filesystem = {
			follow_current_file = true,
			hijack_netrw_behavior = "open_current",
		},
	},
}

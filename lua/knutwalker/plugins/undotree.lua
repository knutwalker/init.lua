return {
	"mbbill/undotree",
	cmd = "UndotreeToggle",
	keys = require("knutwalker.keymap").undotree,
	init = function()
		-- Undotree config, before plugin is loaded
		vim.g.undotree_WindowLayout = 4
		vim.g.undotree_ShortIndicators = 1
		vim.g.undotree_SplitWidth = 40
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}

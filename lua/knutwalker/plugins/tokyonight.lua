function ColorMyPencils(color)
	color = color or "tokyonight-moon"
	vim.cmd.colorscheme(color)
end

-- Tokyo Night colorscheme
return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local tokyonight = require("tokyonight")
		tokyonight.setup({
			style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			light_style = "day", -- The theme is used when the background is set to light
			transparent = false, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = true },
				keywords = {},
				functions = {},
				variables = {},
				-- Background styles. Can be 'dark', 'transparent' or 'normal'
				sidebars = "dark", -- style for sidebars, see below
				floats = "transparent", -- style for floating windows
			},
			-- Set a darker background on sidebar-like windows. For example: `['qf', 'vista_kind', 'terminal', 'packer']`
			sidebars = {
				"qf",
				"vista_kind",
				"terminal",
				-- "packer",
				"spectre_panel",
				"NeogitStatus",
				"help",
				"startuptime",
				"Outline",
			},
			day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
			hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
			dim_inactive = true, -- dims inactive windows
			lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
		})

		tokyonight.load()
		ColorMyPencils()
	end,
}

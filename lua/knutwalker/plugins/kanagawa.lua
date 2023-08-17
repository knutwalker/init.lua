-- Kanagawa colorscheme
return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local kanagawa = require("kanagawa")
		kanagawa.setup({
			theme = "dragon", -- Load "dragon" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "dragon",
				light = "lotus",
			},
			undercurl = true, -- enable undercurls
			commentStyle = {},
			functionStyle = {},
			keywordStyle = {},
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = true, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			overrides = function(colors)
				local palette = colors.palette
				local theme = colors.theme
				return {
					GitSignsAdd = { fg = palette.autumnGreen },
					GitSignsChange = { fg = palette.autumnYellow },
					GitSignsDelete = { fg = palette.autumnRed },

					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					-- Save an hlgroup with dark background and dimmed foreground
					-- so that you can use it where your still want darker windows.
					-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					-- Popular plugins that open floats will link to NormalFloat by default;
					-- set their background accordingly if you wish to keep them dark and borderless
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				}
			end,
		})

		kanagawa.load()
		require("knutwalker.colors").set()
	end,
}

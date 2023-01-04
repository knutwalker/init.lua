return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = {
		options = {
			icons_enabled = false,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{
					"filename",
					path = 1, -- show relative path to project root
				},
				{
					function()
						local ret = require("nvim-navic").get_location()
						return ret:len() > 2000 and "navic error" or ret
					end,
					cond = function()
						return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
					end,
				},
			},
			lualine_x = {
				{
					"encoding",
					separator = "",
					cond = function()
						return vim.bo.fileencoding ~= "utf-8"
					end,
				},
				{ "filetype", separator = "" },
				{
					"fileformat",
					separator = "",
					cond = function()
						return vim.bo.fileformat ~= "unix"
					end,
				},
			},
			lualine_y = { "progress", "searchcount" },
			lualine_z = { { "location", separator = "", padding = 0 }, "ObsessionStatus" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = { "fugitive", "neo-tree", "nvim-dap-ui", "symbols-outline", "quickfix" },
	},
}

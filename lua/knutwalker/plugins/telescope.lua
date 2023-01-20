return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = { "Telescope", "Tel" },
	dependencies = {
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-symbols.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "gmake" },
		{ "LukasPietzschmann/telescope-tabs", config = true, lazy = true },
	},
	keys = require("knutwalker.keymap").telescope,
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					prompt_position = "top",
					width = 0.9,
					preview_cutoff = 0,
				},
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<c-y>"] = function(...)
							require("trouble.providers.telescope").open_with_trouble(...)
						end,
					},
					n = {
						["<c-y>"] = function(...)
							require("trouble.providers.telescope").open_with_trouble(...)
						end,
					},
				},
			},
			pickers = {
				buffers = {
					sort_mru = true,
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,
}

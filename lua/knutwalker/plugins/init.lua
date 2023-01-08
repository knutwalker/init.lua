local keymap = require("knutwalker.keymap")

return {
	{ "nvim-lua/plenary.nvim", lazy = true },

	{ "kyazdani42/nvim-web-devicons", lazy = true },

	{ "tpope/vim-fugitive", cmd = "Git", keys = keymap.git },

	{ "tpope/vim-unimpaired", event = "BufReadPost" },

	{ "tpope/vim-obsession", event = "VeryLazy" },

	{ "makerj/vim-pdf", event = "BufReadPre *.pdf" },

	{ "editorconfig/editorconfig-vim", event = "BufReadPre" },

	{ "mg979/vim-visual-multi", branch = "master", event = "BufReadPost" },

	{ "dstein64/vim-startuptime", cmd = "StartupTime" },

	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },

	{ "ThePrimeagen/harpoon", keys = keymap.harpoon },

	{ "mbbill/undotree", cmd = "UndotreeToggle", keys = keymap.undotree },

	{ "folke/which-key.nvim", config = true },

	{ "windwp/nvim-autopairs", event = "InsertEnter", config = { check_ts = true } },

	{ "szw/vim-maximizer", keys = keymap.maximizer, cmd = "MaximizerToggle" },

	{ "famiu/bufdelete.nvim", keys = keymap.bufdelete, cmd = { "Bdelete" } },

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		config = {
			ohar = "",
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = true,
			show_trailing_blankline_indent = true,
		},
	},

	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
		keys = keymap.symbols_outline,
		config = true,
	},

	{
		"karb94/neoscroll.nvim",
		enabled = false,
		event = "VeryLazy",
		config = {
			-- All these keys will be mapped to their corresponding default scrolling animation
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			hide_cursor = true, -- Hide cursor while scrolling
			stop_eof = true, -- Stop at <EOF> when scrolling downwards
			respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
			cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
			easing_function = nil, -- Default easing function
			pre_hook = nil, -- Function to run before the scrolling animation starts
			post_hook = nil, -- Function to run after the scrolling animation ends
			performance_mode = false, -- Disable "Performance Mode" on all buffers.
		},
	},

	{
		"saecki/crates.nvim",
		event = { "BufReadPre Cargo.toml" },
		keys = keymap.crates,
		config = true,
	},

	{
		"ThePrimeagen/refactoring.nvim",
		keys = keymap.refactoring,
		config = function()
			require("refactoring").setup({})
			require("telescope").load_extension("refactoring")
		end,
	},

	{
		"echasnovski/mini.comment",
		branch = "stable",
		event = "BufReadPost",
		config = function()
			require("mini.comment").setup()
		end,
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		keys = keymap.todo_comments,
		config = true,
	},

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = keymap.trouble,
		config = {
			auto_open = false,
			auto_jump = {},
			use_diagnostic_signs = true,
		},
	},

	{
		"princejoogie/chafa.nvim",
		dependencies = {
			"m00qek/baleia.nvim",
		},
		event = {
			"BufReadPre *.jpeg",
			"BufReadPre *.jpg",
			"BufReadPre *.png",
			"BufReadPre *.bmp",
			"BufReadPre *.webp",
			"BufReadPre *.tiff",
			"BufReadPre *.tif",
		},
		cmd = "ViewImage",
		config = true,
	},
}

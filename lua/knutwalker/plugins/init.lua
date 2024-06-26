local keymap = require("knutwalker.keymap")

return {
	{ "nvim-lua/plenary.nvim", lazy = true },

	{ "kyazdani42/nvim-web-devicons", lazy = true },

	{ "tpope/vim-fugitive", cmd = "Git", keys = keymap.git(), enabled = false },

	{ "tpope/vim-unimpaired", event = "BufReadPost" },

	{ "tpope/vim-obsession", event = "VeryLazy" },

	{ "makerj/vim-pdf", event = "BufReadPre *.pdf", enabled = false },

	{ "mg979/vim-visual-multi", branch = "master", event = "BufReadPost" },

	{ "dstein64/vim-startuptime", cmd = "StartupTime" },

	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood", enabled = false },

	{ "folke/which-key.nvim", config = true },

	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = { check_ts = true } },

	{ "declancm/maximize.nvim", keys = keymap.maximizer(), opts = { default_keymaps = false } },

	{ "famiu/bufdelete.nvim", keys = keymap.bufdelete(), cmd = { "Bdelete" } },

	{ "avli/vim-lox-syntax", event = { "BufReadPre *.lox", "BufReadPre *.crox", "BufReadPre *.bollox" } },

	{ "andrewferrier/debugprint.nvim", keys = "g?", config = true },

	{ "rareitems/put_at_end.nvim", keys = keymap.put_at_end() },

	{ "pwntester/octo.nvim", cmd = "Octo", config = true, enabled = false },

	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = keymap.harpoon(),
		setup = function()
			require("telescope").load_extension("harpoon")
		end,
	},

	{
		"chrisgrieser/nvim-various-textobjs",
		event = "BufReadPost",
		opts = {
			useDefaultKeymaps = true,
			disabledKeymaps = { "gc" },
		},
	},

	{
		"roobert/surround-ui.nvim",
		keys = "<leader>i",
		dependencies = {
			"kylechui/nvim-surround",
			"folke/which-key.nvim",
		},
		config = function()
			require("surround-ui").setup({
				root_key = "i",
			})
		end,
	},

	{
		"echasnovski/mini.move",
		event = "BufReadPost",
		config = function()
			require("mini.move").setup()
		end,
	},

	{
		"RaafatTurki/hex.nvim",
		config = true,
		keys = keymap.hex(),
		cmd = {
			"HexDump",
			"HexAssemble",
			"HexToggle",
		},
		event = { "BufReadPre *.out", "BufReadPre *.bin" },
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		main = "ibl",
		opts = {
			indent = {
				char = "",
			},
			whitespace = {
				remove_blankline_trail = false,
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
			},
		},
	},

	{
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
		keys = keymap.symbols_outline(),
		config = true,
	},

	{
		"karb94/neoscroll.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
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
		keys = keymap.crates(),
		config = true,
	},

	{
		"ThePrimeagen/refactoring.nvim",
		keys = keymap.refactoring(),
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
			require("mini.comment").setup({
				options = {
					ignore_blank_line = false,
				},
				mappings = {
					comment = "g/", -- Normal and Visual modes
					comment_line = "g//", -- Toggle comment on current line
					comment_visual = "g/", -- Toggle comment on visual selection
					textobject = "gc", -- Define 'comment' textobject (like `dgc` - delete whole comment block)
				},
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		keys = keymap.todo_comments(),
		config = true,
	},

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = keymap.trouble(),
		opts = {
			auto_open = false,
			auto_jump = {},
			use_diagnostic_signs = true,
		},
	},

	{
		"princejoogie/chafa.nvim",
		enabled = false,
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

	{
		"kosayoda/nvim-lightbulb",
		event = "BufReadPre",
		opts = {
			autocmd = {
				-- setup autocommands to update availability
				enabled = true,
			},
			sign = {
				-- disable gutter sign
				enabled = false,
			},
			status_text = {
				-- enable text for status line
				enabled = true,
				text = "💡",
				text_unavailable = "",
			},
		},
	},

	{
		"numToStr/Navigator.nvim",
		keys = keymap.navigator(),
		config = true,
	},

	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = keymap.oil(),
	},

	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = keymap.supermaven(),
				ignore_filetypes = { gitcommit = true },
				disable_inline_completion = false, -- `true` disables inline completion for use with cmp
				disable_keymaps = false, -- `true` disables built in keymaps for more manual control
			})
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		keys = keymap.copilot(),
		enabled = false,
		opts = {
			panel = {
				enabled = true,
			},
			suggestion = {
				enabled = true,
				auto_trigger = false,
				keymap = {
					accept = "<C-l>",
				},
			},
			filetypes = { TelescopePrompt = false, markdown = true, yaml = true },
		},
	},

	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		opts = {
			auto_load = false,
			syntax = true,
			app = "browser",
		},
		keys = keymap.peek(),
		event = {
			"BufReadPre *.md",
			"BufReadPre *.markdown",
		},
	},

	{
		"ellisonleao/glow.nvim",
		cmd = "Glow",
		keys = keymap.glow(),
		opts = {
			glow_path = "/opt/homebrew/bin/glow",
			width_ratio = 0.8,
			height_ratio = 0.8,
		},
	},

	{
		"DreamMaoMao/yazi.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gy", "<cmd>Yazi<CR>", desc = "Toggle [Y]azi" },
		},
	},
}

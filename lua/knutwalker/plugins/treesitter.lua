return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {
				patterns = {
					rust = {
						"impl_item",
						"match",
						"loop",
					},
				},
			},
		},
		{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or 'all'
			ensure_installed = {
				-- vim related things
				"help",
				"c",
				"lua",
				"vim",
				-- git things
				"diff",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				-- proper languages
				"rust",
				"java",
				"kotlin",
				"scala",
				"python",
				"zig",
				-- other languages
				"comment", -- comment tags like TO_DO
				"bash",
				"dockerfile",
				"dot",
				"ebnf",
				"jq",
				"json",
				"make",
				"markdown",
				"markdown_inline",
				"proto",
				"regex",
				"toml",
				-- frontend stuff
				"css",
				"scss",
				"html",
				"javascript",
				"typescript",
			},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			highlight = {
				-- `false` will disable the whole extension
				enable = true,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},

			-- Use tree sitter to power the = indentation operation
			indent = { enable = true },

			-- incrementally increase selection
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<M-Up>",
					node_incremental = "<M-Up>",
					node_decremental = "<M-Down>",
					scope_incremental = "<M-Right>",
				},
			},

			-- Tree sitter powered text objects and navigation
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
						["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },
						["ab"] = { query = "@block.outer", desc = "Select outer block" },
						["ib"] = { query = "@block.inner", desc = "Select inner block" },
						["af"] = { query = "@function.outer", desc = "Select outer function" },
						["if"] = { query = "@function.inner", desc = "Select inner function" },
						["ac"] = { query = "@class.outer", desc = "Select outer class" },
						["ic"] = { query = "@class.inner", desc = "Select inner class" },
						["a/"] = { query = "@comment.outer", desc = "Select outer comment" },
						["i/"] = { query = "@comment.outer", desc = "Select outer comment" },

						["a<leader>a"] = { query = "@call.outer", desc = "Select outer call" },
						["i<leader>a"] = { query = "@call.inner", desc = "Select inner call" },
						["a<leader>c"] = { query = "@conditional.outer", desc = "Select outer conditional" },
						["i<leader>c"] = { query = "@conditional.inner", desc = "Select inner conditional" },
						["a<leader>l"] = { query = "@loop.outer", desc = "Select outer loop" },
						["i<leader>l"] = { query = "@loop.inner", desc = "Select inner loop" },
						["a<leader>s"] = { query = "@statement.outer", desc = "Select outer statement" },
						["i<leader>s"] = { query = "@statement.inner", desc = "Select inner statement" },
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = { query = "@function.outer", desc = "Goto next function" },
						["]]"] = { query = "@class.outer", desc = "Goto next class" },
					},
					goto_next_end = {
						["]M"] = { query = "@function.outer", desc = "Goto the end of the next function" },
						["]["] = { query = "@class.outer", desc = "Goto the end of the next class" },
					},
					goto_previous_start = {
						["[m"] = { query = "@function.outer", desc = "Goto previous function" },
						["[["] = { query = "@class.outer", desc = "Goto previous class" },
					},
					goto_previous_end = {
						["[M"] = { query = "@function.outer", desc = "Goto the end of the previous function" },
						["[]"] = { query = "@class.outer", desc = "Goto the end of the previous class" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				lsp_interop = {
					enable = true,
					border = "none",
					floating_preview_opts = {},
					peek_definition_code = {
						["gk"] = "@function.outer",
						["gh"] = "@class.outer",
					},
				},
			},
		})
		local lox_ts_path = vim.fn.stdpath("data") .. "/lox/tree-sitter-lox"
		local just_ts_path = vim.fn.stdpath("data") .. "/just/tree-sitter-just"
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.lox = {
			install_info = {
				url = lox_ts_path,
				files = { "src/parser.c" },
				branch = "main",
				generate_requires_npm = true,
				requires_generate_from_grammar = false,
			},
			filetype = "lox",
		}
		parser_config.just = {
			install_info = {
				url = just_ts_path,
				files = { "src/parser.c", "src/scanner.cc" },
				branch = "update-parser",
				use_makefile = true,
			},
			filetype = "just",
		}
		require("plenary.filetype").add_file("crox")
	end,
}

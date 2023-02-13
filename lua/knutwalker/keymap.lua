local M = {}

function M.copilot()
	return {
		{ "<leader>Cs", ":Copilot status<CR>", desc = "Show [C]opilot [s]tatus" },
		{ "<leader>Cv", ":Copilot version<CR>", desc = "Show [C]opilot [v]ersion" },
		{ "<leader>Cl", ":Copilot panel<CR>", desc = "Open [C]opilot [l]ist" },
		{
			"<leader>Ca",
			function()
				require("copilot.suggestion").toggle_auto_trigger()
			end,
			desc = "Toggle [C]opilot [a]uto-trigger",
		},
		{ "<leader>CC", ":Copilot toggle<CR>", desc = "Toggle [C]opilot" },
		{ "<leader>Cd", ":CopilotDetach<CR>", desc = "[D]etach [C]opilot from buffer" },
		{ "<leader>CS", ":CopilotStop<CR>", desc = "[S]top [C]opilot" },
	}
end

function M.crates()
	return {
		{
			"<leader>ct",
			function()
				require("crates").toggle()
			end,
			desc = "[t]oggle [c]rate UI elements",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cr",
			function()
				require("crates").reload()
			end,
			desc = "[r]eload [c]rate data",
			noremap = true,
			silent = true,
		},
		{
			"<leader>ck",
			function()
				require("crates").show_popup()
			end,
			desc = "Show [c]rates popup",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cK",
			function()
				require("crates").show_popup()
			end,
			desc = "Show [c]rates popup",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cc",
			function()
				require("crates").show_crate_popup()
			end,
			desc = "Show [c]rate details popup",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cv",
			function()
				require("crates").show_versions_popup()
			end,
			desc = "Show [c]rates [v]ersions popup",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cf",
			function()
				require("crates").show_features_popup()
			end,
			desc = "Show [c]rates [f]eatures popup",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cd",
			function()
				require("crates").show_dependencies_popup()
			end,
			desc = "Show [c]rates [d]ependencies popup",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cu",
			function()
				require("crates").update_crate()
			end,
			mode = { "n", "v" },
			desc = "[u]pdate [c]rate on line/in selection",
			noremap = true,
			silent = true,
		},
		{
			"<leader>ca",
			function()
				require("crates").update_all_crates()
			end,
			desc = "Update [a]ll [c]rates",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cU",
			function()
				require("crates").upgrade_crate()
			end,
			mode = { "n", "v" },
			desc = "[U]pgrade [c]rate on line/in selection",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cA",
			function()
				require("crates").upgrade_all_crates()
			end,
			desc = "Upgrade [A]ll [c]rates",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cH",
			function()
				require("crates").open_homepage()
			end,
			desc = "Open [c]rate [H]omepage",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cR",
			function()
				require("crates").open_repository()
			end,
			desc = "Dpen [c]rate [R]epository",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cD",
			function()
				require("crates").open_documentation()
			end,
			desc = "Open [c]rate [D]ocumentation",
			noremap = true,
			silent = true,
		},
		{
			"<leader>cC",
			function()
				require("crates").open_crates_io()
			end,
			desc = "Open [c]rates.io",
			noremap = true,
			silent = true,
		},
	}
end

function M.dap()
	return {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debugger: Start",
		},
		{
			"<S-F5>",
			function()
				require("dap").terminate()
			end,
			desc = "Debugger: Stop",
		},
		{
			"<C-F5>",
			function()
				require("dap").restart_frame()
			end,
			desc = "Debugger: Restart",
		},
		{
			"<F6>",
			function()
				require("dap").pause()
			end,
			desc = "Debugger: Pause",
		},
		{
			"<S-F8>",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debugger: Toggle Breakpoint",
		},
		{
			"<F8>",
			function()
				require("dap").step_over()
			end,
			desc = "Debugger: Step Over",
		},
		{
			"<F7>",
			function()
				require("dap").step_into()
			end,
			desc = "Debugger: Step Into",
		},
		{
			"<S-F7>",
			function()
				require("dap").step_out()
			end,
			desc = "Debugger: Step Out",
		},
		{
			"<leader>Db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle [B]reakpoint (S-F8)",
		},
		{
			"<leader>DBB",
			function()
				require("dap").clear_breakpoints()
			end,
			desc = "Clear [B]reakpoints",
		},
		{
			"<leader>DB?",
			function()
				require("dap").list_breakpoints()
			end,
			desc = "List [B]reakpoints",
		},
		{
			"<leader>DBc",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Set [B]reakpoint with [c]ondition",
		},
		{
			"<leader>DBl",
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			desc = "Set [B]reakpoint with [l]og message",
		},
		-- trying to align with lldb commands
		{
			"<leader>Dr",
			function()
				require("dap").continue()
			end,
			desc = "[R]un (F5)",
		},
		{
			"<leader>Dc",
			function()
				require("dap").continue()
			end,
			desc = "[C]ontinue (F5)",
		},
		{
			"<leader>Ds",
			function()
				require("dap").step_into()
			end,
			desc = "[S]tep Into (F7)",
		},
		{
			"<leader>Dn",
			function()
				require("dap").step_over()
			end,
			desc = "[N]ext statement (Step Over) (F8)",
		},
		{
			"<leader>Df",
			function()
				require("dap").step_out()
			end,
			desc = "[F]inish current frame (Step Out) (S-F7)",
		},
		{
			"<leader>DS",
			function()
				require("dap").step_back()
			end,
			desc = "[S]tep Back (if possible)",
		},
		{
			"<leader>Dj",
			function()
				require("dap").down()
			end,
			desc = "Go down in current stackframe",
		},
		{
			"<leader>Dk",
			function()
				require("dap").up()
			end,
			desc = "Go up in current stackframe",
		},
		{
			"<leader>Dg",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "[G]o to current cursor",
		},
		{
			"<leader>DG",
			function()
				require("dap").goto_(tonumber(vim.fn.input("Line > ")))
			end,
			desc = "[G]o to and skip to the fiven line",
		},
		{
			"<leader>Dp",
			function()
				require("dap").pause()
			end,
			desc = "Pause (F6)",
		},
		{
			"<leader>DR",
			function()
				require("dap").restart_frame()
			end,
			desc = "Restart (C-F5)",
		},
		{
			"<leader>Dl",
			function()
				require("dap").run_last()
			end,
			desc = "Re-run [l]ast debug session",
		},
		{
			"<leader>Dq",
			function()
				require("dap").close()
			end,
			desc = "Close Session",
		},
		{
			"<leader>DQ",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate Session (S-F5})",
		},
		{
			"<leader>D`",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle REPL",
		},
		{
			"<leader>Du",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle Debugger UI",
		},
		{
			"<leader>DK",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Debugger Hover",
		},
		{
			"<leader>DD",
			function()
				require("dap").toggle_breakpoint()
				require("dapui").toggle()
			end,
			desc = "Start debug session: Toggle bp & UI",
		},
	}
end

function M.dial()
	return {
		{
			"<C-a>",
			function()
				return require("dial.map").inc_normal()
			end,
			desc = "Increment",
			expr = true,
			noremap = true,
		},
		{
			"<C-x>",
			function()
				return require("dial.map").dec_normal()
			end,
			desc = "Decrement",
			expr = true,
			noremap = true,
		},
		{
			"<C-a>",
			function()
				return require("dial.map").inc_visual()
			end,
			mode = "v",
			desc = "Increment",
			expr = true,
			noremap = true,
		},
		{
			"<C-x>",
			function()
				return require("dial.map").dec_visual()
			end,
			mode = "v",
			desc = "Decrement",
			expr = true,
			noremap = true,
		},
		{
			"g<C-a>",
			function()
				return require("dial.map").inc_gvisual()
			end,
			mode = "v",
			desc = "Increment",
			expr = true,
			noremap = true,
		},
		{
			"g<C-x>",
			function()
				return require("dial.map").dec_gvisual()
			end,
			mode = "v",
			desc = "Decrement",
			expr = true,
			noremap = true,
		},
	}
end

function M.harpoon()
	return {
		{
			"<leader>i",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Add file to harpoon",
		},

		{
			"<leader>fi",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Toggle Harpoon [I]nterface",
		},

		{
			"<C-4>",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "Navigate to first file",
		},

		{
			"<C-5>",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "Navigate to second file",
		},

		{
			"<C-6>",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "Navigate to third file",
		},

		{
			"<C-7>",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "Navigate to fourth file",
		},

		{
			"<C-8>",
			function()
				require("harpoon.ui").nav_file(5)
			end,
			desc = "Navigate to fifth file",
		},
	}
end

function M.maximizer()
	return {
		{ "<C-m>", ":MaximizerToggle<CR>", silent = true, desc = "Toggle [m]aximizer" },
	}
end

function M.neotree()
	return {
		{
			"<leader>t",
			function()
				require("neo-tree.command").execute({ action = "focus", reveal = true })
			end,
			desc = "Open/Focus File[t]ree",
		},
		{
			"<leader>T",
			function()
				require("neo-tree.command").execute({ action = "close" })
			end,
			desc = "Close File[t]ree",
		},
	}
end

function M.refactoring()
	return {
		{
			"<leader>rs",
			function()
				require("refactoring").select_refactor()
			end,
			mode = { "n", "v" },
			silent = true,
			expr = false,
			desc = "Refactor [S]elect",
		},
		{
			"<leader>r/",
			"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
			mode = { "n", "v" },
			noremap = true,
			desc = "Search available refactors",
		},
		{
			"<leader>rf",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
			mode = "v",
			noremap = true,
			silent = true,
			expr = false,
			desc = "Refactor Extract [f]unction",
		},
		{
			"<leader>rF",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
			mode = "v",
			noremap = true,
			silent = true,
			expr = false,
			desc = "Refactor function to [F]ile",
		},
		{
			"<leader>rv",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
			mode = "v",
			noremap = true,
			silent = true,
			expr = false,
			desc = "Refactor Extract [v]ariable",
		},
		{
			"<leader>ri",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
			mode = "v",
			noremap = true,
			silent = true,
			expr = false,
			desc = "Refactor [i]nline variable",
		},
		{
			"<leader>rb",
			[[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
			noremap = true,
			silent = true,
			expr = false,
			desc = "Refactor Extract [b]lock",
		},
		{
			"<leader>rB",
			[[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
			noremap = true,
			silent = true,
			expr = false,
			desc = "Refactor [B]lock to File",
		},
		{
			"<leader>ri",
			[[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
			noremap = true,
			silent = true,
			expr = false,
			desc = "Refactor [i]nline variable",
		},
	}
end

function M.telescope()
	return {
		{
			"<leader>/",
			function()
				local builtin = require("telescope.builtin")
				local opts = {
					show_untracked = true,
				}
				local ok = pcall(builtin.git_files, opts)
				if not ok then
					builtin.find_files(opts)
				end
			end,
			desc = "Search files",
		},
		{
			"<leader>?",
			function()
				require("telescope.builtin").find_files({ no_ignore = true })
			end,
			desc = "Search all files",
		},
		{
			"<leader>b",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Search [b]uffers",
		},
		{
			"<leader>e",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "Search [e]dit history",
		},
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "[F]ind all [F]iles",
		},
		{
			"<leader>fF",
			function()
				require("telescope.builtin").find_files({
					hidden = true,
					no_ignore = true,
				})
			end,
			desc = "[F]ind all [F]iles (including hidden)",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "[F]ind [g]rep string across files",
		},
		{
			"<leader>fG",
			function()
				require("telescope.builtin").live_grep({
					hidden = true,
					no_ignore = true,
					additional_args = function(args)
						return vim.list_extend(args, { "--hidden", "--no-ignore" })
					end,
				})
			end,
			desc = "[F]ind [g]rep string across files (including hidden)",
		},
		{
			"<leader>f*",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "[F]ind [*]word under cursor across files",
		},
		{
			"<leader>f/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find()
			end,
			desc = "[F]uzzily [/]search in current buffer]",
		},
		{
			"<leader>fr",
			function()
				require("telescope.builtin").resume()
			end,
			desc = "[F]ind [r]esume last search",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "[F]ind [h]elp tags",
		},
		{
			"<leader>f'",
			function()
				require("telescope.builtin").marks()
			end,
			desc = "[F]ind [']marks",
		},
		{
			"<leader>fM",
			function()
				require("telescope.builtin").man_pages()
			end,
			desc = "[F]ind [M]an",
		},
		{
			[[<leader>"]],
			function()
				require("telescope.builtin").registers()
			end,
			desc = [[[F]ind ["]Registers]],
		},
		{
			[[<leader>f"]],
			function()
				require("telescope.builtin").registers()
			end,
			desc = [[[F]ind ["]Registers]],
		},
		{
			"<leader>fk",
			function()
				require("telescope.builtin").keymaps()
			end,
			desc = "[F]ind [k]eymaps",
		},
		{
			"<leader>fc",
			function()
				require("telescope.builtin").commands()
			end,
			desc = "[F]ind [c]commands",
		},
		{
			"<leader>fe",
			function()
				require("telescope.builtin").symbols({ sources = { "emoji" } })
			end,
			desc = "[F]ind [e]mojis",
		},
		{
			"<leader>fE",
			function()
				require("telescope.builtin").symbols({ sources = { "emoji", "kaomoji", "gitmoji" } })
			end,
			desc = "[F]ind All [E]mojis",
		},
		{
			"<leader>fq",
			function()
				require("telescope.builtin").quickfix()
			end,
			desc = "[F]ind [q]uickfix items",
		},
		{
			"<leader>gg",
			function()
				require("telescope.builtin").git_status()
			end,
			desc = "[G]it status",
		},
		{
			"<leader>gb",
			function()
				require("telescope.builtin").git_branches()
			end,
			desc = "[G]it [b]ranches",
		},
		{
			"<leader>gc",
			function()
				require("telescope.builtin").git_commits()
			end,
			desc = "[G]it [c]ommits",
		},
		{
			"<leader>gd",
			function()
				require("telescope.builtin").git_bcommits()
			end,
			desc = "[G]it [d]iff current file",
		},
		{
			"<leader>{",
			function()
				require("telescope.builtin").diagnostics()
			end,
			desc = "Search Diagnostics",
		},
		{
			"<leader>f<tab>",
			function()
				require("telescope-tabs").list_tabs()
			end,
			desc = "Search Tabs",
		},
		{
			"<leader><tab>`",
			function()
				require("telescope-tabs").go_to_previous()
			end,
			desc = "Go to previous tab",
		},
	}
end

function M.todo_comments()
	return {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous todo comment",
		},
		{
			"<leader>ft",
			"<cmd>TodoTelescope<CR>",
			desc = "Find [T]odos",
		},
		{
			"<leader>fT",
			"<cmd>TodoTrouble<CR>",
			desc = "Find [T]odos in Touble",
		},
	}
end

function M.trouble()
	return {
		{
			"<leader>f{",
			"<CMD>TroubleToggle workspace_diagnostics<CR>",
			desc = "Open workspace diagnostics in Trouble",
			silent = true,
			noremap = true,
		},
		{
			"<leader>f[",
			"<CMD>TroubleToggle document_diagnostics<CR>",
			desc = "Open document diagnostics in Trouble",
			silent = true,
			noremap = true,
		},
		{
			"]x",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
			desc = "Jump to the next Trouble item",
			silent = true,
			nowait = true,
		},
		{
			"[x",
			function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end,
			desc = "Jump to the previous Trouble item",
			silent = true,
			nowait = true,
		},
	}
end

function M.zen_mode()
	return {
		{
			"<leader>zz",
			function()
				require("zen-mode").toggle()
				vim.wo.wrap = false
				require("knutwalker.colors").set()
			end,
			desc = "Toggle [Z]en mode",
		},
	}
end

function M.git()
	return {
		{ "<leader>gs", "<CMD>Git<CR>", desc = "[G]it [S]tatus" },
	}
end

function M.undotree()
	return {
		{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle [U]ndo tree" },
	}
end

function M.symbols_outline()
	return {
		{ "<F12>", "<cmd>SymbolsOutline<CR>", mode = { "n", "v", "i" }, desc = "Symbols outline" },
	}
end

function M.bufdelete()
	return {
		{
			"<leader>x",
			"<cmd>Bdelete<CR>",
			desc = "Delete buffer",
		},
		{
			"<leader>X",
			"<cmd>Bdelete!<CR>",
			desc = "Force Delete buffer",
		},
	}
end

function M.put_at_end()
	return {
		{
			"<M-,>",
			function()
				require("put_at_end").put_comma()
			end,
			mode = "i",
			desc = "Put comma at end of line",
		},
		{
			"<leader>,",
			function()
				require("put_at_end").put_comma()
			end,
			desc = "Put comma at end of line",
		},
		{
			"<M-;>",
			function()
				require("put_at_end").put_semicolon()
			end,
			mode = "i",
			desc = "Put semicolon at end of line",
		},
		{
			"<leader>;",
			function()
				require("put_at_end").put_semicolon()
			end,
			desc = "Put semicolon at end of line",
		},
	}
end

function M.hex()
	return {
		{
			"<leader>zx",
			function()
				require("hex").toggle()
			end,
			desc = "Toggle He[x]",
		},
	}
end

function M.navigator()
	return {
		{
			"<C-h>",
			function()
				require("Navigator").left()
			end,
			desc = "Move to the next pane left",
			mode = { "n", "t" },
		},
		{
			"<C-j>",
			function()
				require("Navigator").down()
			end,
			desc = "Move to the next pane down",
			mode = { "n", "t" },
		},
		{
			"<C-k>",
			function()
				require("Navigator").up()
			end,
			desc = "Move to the next pane up",
			mode = { "n", "t" },
		},
		{
			"<C-l>",
			function()
				require("Navigator").right()
			end,
			desc = "Move to the next pane right",
			mode = { "n", "t" },
		},
		{
			[[<C-\]],
			function()
				require("Navigator").previous()
			end,
			desc = "Move to the previous pane",
			mode = { "n", "t" },
		},
	}
end

return M

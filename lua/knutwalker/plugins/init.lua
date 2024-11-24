local keymap = require("knutwalker.keymap")

return {
    { "nvim-lua/plenary.nvim",         lazy = true },

    { "tpope/vim-unimpaired",          event = "BufReadPost" },

    { "folke/which-key.nvim",          config = true },

    { "declancm/maximize.nvim",        keys = keymap.maximizer(),                                                 opts = { default_keymaps = false } },

    { "famiu/bufdelete.nvim",          keys = keymap.bufdelete(),                                                 cmd = { "Bdelete" } },

    { "avli/vim-lox-syntax",           event = { "BufReadPre *.lox", "BufReadPre *.crox", "BufReadPre *.bollox" } },

    { "andrewferrier/debugprint.nvim", event = { "BufReadPost" },                                                 config = true },

    { "rareitems/put_at_end.nvim",     keys = keymap.put_at_end() },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = keymap.harpoon(),
        setup = function()
            require("harpoon"):setup()
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
        version = '*',
        config = function()
            require("mini.move").setup()
        end,
    },

    {
        'echasnovski/mini.operators',
        event = "BufReadPost",
        version = '*',
        config = function()
            require("mini.operators").setup()
        end
    },

    {
        'altermo/ultimate-autopair.nvim',
        event = { 'InsertEnter' },
        branch = 'v0.6',
        opts = {
            map = true,
            pair_map = true,
            cmap = false,
            pair_cmap = false,
            bs = { enable = false },
            fastwarp = { enable = false },
            close = { enable = true, map = '<C-t>' },
            tabout = { enable = true, hopout = true, map = '<C-e>' },
        },
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
        "saecki/crates.nvim",
        event = { "BufReadPre Cargo.toml" },
        keys = keymap.crates(),
        config = true,
    },

    {
        "echasnovski/mini.comment",
        version = false,
        event = "BufReadPost",
        config = function()
            require("mini.comment").setup({
                options = {
                    ignore_blank_line = false,
                    pad_comment_parts = false,
                },
                mappings = {
                    comment = "g/",        -- Normal and Visual modes
                    comment_line = "g//",  -- Toggle comment on current line
                    comment_visual = "g/", -- Toggle comment on visual selection
                    textobject = "gc",     -- Define 'comment' textobject (like `dgc` - delete whole comment block)
                },
            })
        end,
    },

    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTelescope" },
        event = "BufReadPost",
        keys = keymap.todo_comments(),
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
        opts = {
            columns = {
                "icon",
                "permissions",
                "size",
            },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = keymap.oil(),
    },

    {
        "supermaven-inc/supermaven-nvim",
        cmd = {
            "SupermavenStop",
            "SupermavenStart",
            "SupermavenUsePro",
            "SupermavenStatus",
            "SupermavenToggle",
            "SupermavenLogout",
            "SupermavenShowLog",
            "SupermavenUseFree",
            "SupermavenRestart",
            "SupermavenClearLog",
        },
        config = function()
            require("supermaven-nvim").setup({
                keymaps = keymap.supermaven(),
                ignore_filetypes = { gitcommit = true, oil = true },
                log_level = "warn",
                disable_inline_completion = false, -- `true` disables inline completion for use with cmp
                disable_keymaps = false,           -- `true` disables built in keymaps for more manual control
            })
        end,
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
        keys = keymap.yazi(),
    },

    {
        'rmagatti/auto-session',
        opts = {
            auto_session_suppress_dirs = { '/', '~/', '~/Downloads', '~/dev/tmp/' },
        },
    },

    {
        "OXY2DEV/markview.nvim",
        lazy = false, -- Recommended
    },

    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        keys = keymap.undotree(),
        init = function()
            -- Undotree config, before plugin is loaded
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_ShortIndicators = 1
            vim.g.undotree_SplitWidth = 60
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    },

    {
        "vim-test/vim-test",
        init = function()
            vim.g['test#strategy'] = 'neovim'
        end,
        keys = keymap.vimtest(),
    }
}

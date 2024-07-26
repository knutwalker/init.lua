return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    event = "BufReadPre",
    dependencies = {
        -- LSP Support
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Improved Rust support
        { "simrat39/rust-tools.nvim" },

        -- Java LSP support
        { "mfussenegger/nvim-jdtls" },

        -- Formatting
        "nvimtools/none-ls.nvim",
        "jayp0521/mason-null-ls.nvim",

        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "petertriho/cmp-git",
        "hrsh7th/cmp-emoji",
        "saadparwaiz1/cmp_luasnip",

        -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",

        -- Progress Report
        { "j-hui/fidget.nvim",        tag = "legacy" },

        -- LSP kind symbols for completion items
        "onsails/lspkind-nvim",

        -- Inline diagnostics
        {
            "rachartier/tiny-inline-diagnostic.nvim",
            event = "VeryLazy",
        },

        -- Code Actions
        {
            "rachartier/tiny-code-action.nvim",
            event = "LspAttach",
            opts = {
                telescope_opts = {
                    layout_strategy = "vertical",
                    layout_config = {
                        mirror = true,
                        preview_height = { 0.7, min = 10 }
                    },
                },
            }
        },

        -- File location
        { "SmiteshP/nvim-navic",      lazy = true },

        -- LSP Signature
        { "ray-x/lsp_signature.nvim", config = true },

        -- Incremental renaming
        { "smjonas/inc-rename.nvim",  config = true },
    },
    config = function()
        local lsp = require("lsp-zero")

        require("knutwalker.plugins.lsp.cmp").setup(lsp)
        require("knutwalker.plugins.lsp.diagnostics").setup_before_lsp()
        lsp.on_attach(require("knutwalker.plugins.lsp.attach").setup())

        lsp.set_preferences({
            -- use simple letters instead of fancy icons
            sign_icons = {
                error = "E",
                warn = "W",
                hint = "H",
                info = "I",
            },
            -- Don't setup default keymap, we configure our own
            set_lsp_keymaps = false,
            -- Don't configure diagnostics, we do this ourselves
            configure_diagnostics = false,
        })

        -- configure yaml language server
        lsp.configure("yamlls", {
            settings = {
                yaml = { keyOrdering = false },
            },
        })

        lsp.configure("cypher_ls", {})

        -- save configs for RA/JDT and null-ls since we set those up manually
        local rust_lsp_opts = lsp.build_options("rust_analyzer", {})
        local jdtls_lsp_opts = lsp.build_options("jdtls", {})

        lsp.setup()

        local function mason_lspconfig_setup()
            local lspconfig = require("lspconfig")

            local function set_lspconfig(server, lsp_options)
                lspconfig[server].setup(lsp_options)
            end

            set_lspconfig("sourcekit", {
                capabilities = {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                },
            })

            return {
                lsp.default_setup,
                lua_ls = function()
                    local lua_opts = lsp.nvim_lua_ls()
                    set_lspconfig("lua_ls", lua_opts)
                end,
            }
        end

        require("mason").setup({})
        require("mason-null-ls").setup({})
        require("mason-lspconfig").setup({
            handlers = mason_lspconfig_setup(),
        })

        -- Setup LSP diagnostics
        require("knutwalker.plugins.lsp.diagnostics").setup_after_lsp()

        -- Configure rust-tools
        require("knutwalker.plugins.lsp.rust").setup(rust_lsp_opts)

        -- Configure JDT ls
        require("knutwalker.plugins.lsp.java").setup(jdtls_lsp_opts)

        -- Configure Formatter

        -- Configure git source
        require("cmp_git").setup()

        -- enable progress report
        require("fidget").setup()
    end,
}

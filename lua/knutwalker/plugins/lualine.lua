return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
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
                statusline = 2500,
                tabline = 2500,
                winbar = 2500,
            },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff" },
            lualine_c = {
                { "diagnostics", separator = "" },
                {
                    function()
                        return require("nvim-lightbulb").get_status_text()
                    end,
                },
            },
            lualine_x = {
                {
                    "filename",
                    separator = "",
                    path = 1,            -- show relative path to project root
                    shorting_target = 0, -- don't shorten the path, important for the jdt fix
                    fmt = function(str)
                        -- only print the jar/class for jdt paths
                        local m = str:match("jdt://contents/([^?]+)%?=.*")
                        return m or str -- :gsub("%%%%5C", ""):gsub("%%%%3C", ""):gsub("%%%%3E", "")
                    end,
                },
                {
                    "encoding",
                    separator = "",
                    cond = function()
                        return vim.bo.fileencoding ~= "utf-8"
                    end,
                },
                {
                    "fileformat",
                    separator = "",
                    cond = function()
                        return vim.bo.fileformat ~= "unix"
                    end,
                },
            },
            lualine_y = { "progress", "searchcount" },
            lualine_z = {
                { "location", separator = "", padding = 0 },
            },
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
        extensions = { "neo-tree", "nvim-dap-ui", "symbols-outline", "quickfix" },
    },
}

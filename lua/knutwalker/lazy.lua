-- bootstrap from github
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "git@github.com:folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- load lazy
require("lazy").setup("knutwalker.plugins", {
    defaults = { lazy = false },
    install = { colorscheme = { require("knutwalker.colors").default_color_scheme } },
    checker = {
        -- do not automatically check for plugin updates
        enabled = false,
    },
    change_detection = {
        -- Don't notify when changes are found
        notify = false,
    },
    pkg = {
        sources = { "lazy" },
    },
    rocks = {
        enabled = false,
        hererocks = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "getscript",
                "getscriptPlugin",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "tutor",
                "rplugin",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
            },
        },
    },
})
vim.keymap.set("n", "<leader>lz", "<cmd>:Lazy<cr>")

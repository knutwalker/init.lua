-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- go to last loc when opening a buffer
local ignore_buftype = { "quickfix", "nofile", "help" }
local ignore_filetype = { "gitcommit", "gitrebase", "jproperties" }
vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
    callback = function()
        if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
            return
        end

        if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
            -- reset cursor to first line
            vim.cmd([[normal! gg]])
            return
        end

        -- Check if a line was specified one the commandline
        if vim.fn.line(".") > 1 then
            return
        end

        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- relative line numbers in normal mode but
-- absolute line numbers in insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
    desc = "set relativenumber",
    group = vim.api.nvim_create_augroup("set_relativenumber", { clear = true }),
    pattern = "*.*",
    command = "set relativenumber",
})

vim.api.nvim_create_autocmd("InsertEnter", {
    desc = "set number",
    group = vim.api.nvim_create_augroup("set_number", { clear = true }),
    pattern = "*",
    command = "set number norelativenumber",
})

-- use q to close certain windows
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "qf",
        "oil",
        "help",
        "man",
        "notify",
        "lspinfo",
        "copilot",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- apply diagnostics on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "TinyDiagnosticEvent", group = "TinyInlineDiagnosticAutocmds" })
    end,
    group = vim.api.nvim_create_augroup("TinyInlineDiagnosticAutocmdsExt", { clear = true }),
})

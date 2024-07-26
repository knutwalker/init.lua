local M = {}

function M.setup_before_lsp()
    -- Setup diagnostic keymaps
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
    vim.keymap.set("n", "<leader>[", vim.diagnostic.open_float, { desc = "Show diagnostic" })
    vim.keymap.set("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "Set diagnostic to loclist" })

    -- Setup diagnostics
    vim.diagnostic.config({
        -- Sort diagnostics by severity
        severity_sort = true,
        -- Show diagnostics in the sign column
        signs = true,
        -- Update diagnostics live while typing
        -- if false, diagnostics are only updated on InsertLeave
        update_in_insert = true,
        -- Single line diagnostics at the end
        virtual_text = false,
        -- multi line diagnostics in between
        virtual_lines = false,
    })

    -- Toggle between diagnostics on and off
    vim.keymap.set("n", "<leader>]", function() require("tiny-inline-diagnostic").toggle() end,
        { desc = "Toggle LSP diagnostics" })
    vim.keymap.set("i", "<M-S-d>", function() require("tiny-inline-diagnostic").toggle() end,
        { desc = "Toggle LSP diagnostics" })
end

function M.setup_after_lsp()
    require("tiny-inline-diagnostic").setup({
        options = { multiple_diag_under_cursor = false },
    })
end

return M

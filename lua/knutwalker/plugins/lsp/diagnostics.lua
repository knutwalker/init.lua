local M = {}

function M.setup_before_lsp()
    -- go to next/prev diagnostic in severity order
    local function try_goto_diag(direction, severity)
        local pos = direction({ severity = severity })
        if not pos then
            return false
        end

        local win_id = vim.api.nvim_get_current_win()
        vim.api.nvim_win_call(win_id, function()
            vim.cmd("normal! m'")
            vim.api.nvim_win_set_cursor(win_id, { pos[1] + 1, pos[2] })
            vim.cmd("normal! zv")
        end)

        return true
    end

    local function goto_diag(direction)
        for _, severity in ipairs {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        } do
            if try_goto_diag(direction, severity) then
                return
            end
        end

        vim.api.nvim_echo({ { "No more diagnostics", "WarningMsg" } }, false, {})
    end

    -- Setup diagnostic keymaps
    vim.keymap.set("n", "[d", function() goto_diag(vim.diagnostic.get_prev_pos) end,
        { desc = "Go to previous [d]iagnostic" })
    vim.keymap.set("n", "]d", function() goto_diag(vim.diagnostic.get_next_pos) end,
        { desc = "Go to next [d]iagnostic" })

    vim.keymap.set("n", "[D", function() vim.diagnostic.goto_prev({ float = false }) end,
        { desc = "Go to previous diagnostic" })
    vim.keymap.set("n", "]D", function() vim.diagnostic.goto_next({ float = false }) end,
        { desc = "Go to next diagnostic" })

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
        options = { multiple_diag_under_cursor = false, show_source = true, multilines = true },
    })
end

return M

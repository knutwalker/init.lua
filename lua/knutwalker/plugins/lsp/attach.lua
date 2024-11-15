local M = {}

function M.setup()
    -- Setup LSP keymap when attached to an LSP
    -- If rust-analyzer attaches, we use the rust-tools provided actions
    local telescope = require("telescope.builtin")
    local buf = vim.lsp.buf
    local cl = vim.lsp.codelens

    local function on_attach(client, bufnr)
        local bind = function(keys, func, desc, mode)
            if desc then
                desc = "LSP: " .. desc
            end
            if not mode then
                mode = "n"
            end

            vim.keymap.set(mode, keys, func, { buffer = bufnr, remap = false, desc = desc })
        end

        bind("<leader>li", "<cmd>LspInfo<CR>", "Information")
        bind("<leader>lI", "<cmd>NullLsInfo<CR>", "Null-LS Information")

        if client.name == "jdtls" then
            require("knutwalker.plugins.lsp.java").attach(bind)
        end

        if client.name == "rust_analyzer" then
            require("knutwalker.plugins.lsp.rust").attach(bind)
        end

        local capabilities = client.server_capabilities

        local ca = function()
            local success, tca = pcall(require, "tiny-code-action")
            if success then
                tca.code_action()
            else
                buf.code_action()
            end
        end

        bind("<leader><CR>", ca, "Code Action", { "n", "x", "v" })
        bind("<localleader><space>", ca, "Code Action", { "n", "x", "v" })
        bind("<localleader><CR>", function() buf.code_action() end, "Code Action", { "n", "x", "v" })
        bind("<M-Return>", ca, "Code Action", { "n", "x", "v" })
        bind("<M-Return>", ca, "Code Action", { "i" })

        bind("<leader>lr", cl.run, "[R]un Code Lens")
        bind("<leader>lR", cl.refresh, "[R]efresh Code Lens")

        bind("gI", buf.incoming_calls, "[I]ncoming calls")
        bind("gO", buf.outgoing_calls, "[O]utgoing calls")

        bind("<leader>h", function() vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end, "Enable inlay [h]ints")
        bind("<leader>H", function() vim.lsp.inlay_hint.enable(false, { bufnr = bufnr }) end, "Disable inlay [h]ints")

        bind("gl", buf.declaration, "[G]o to dec[l]aration")

        bind("gd", buf.definition, "[G]o to [d]efinition")
        bind("<leader>lgd", telescope.lsp_definitions, "[G]o to [d]efinition")

        bind("<leader>s", telescope.lsp_document_symbols, "Search [s]ymbols in this file")
        bind("<leader>ls", buf.document_symbol, "Search [s]ymbols in this file")

        bind("K", buf.hover, "Hover symbol")
        bind("<M-k>", buf.hover, "Hover symbol", "i")

        bind("H", buf.signature_help, "Signature [H]elp")
        bind("<M-h>", buf.signature_help, "Signature [H]elp", "i")

        bind("gi", buf.implementation, "[G]o to [i]mplementation")
        bind("<leader>lgi", telescope.lsp_implementations, "[G]o to [i]mplementation")

        bind("gr", buf.references, "[G]o to [r]eferences")
        bind("<leader>lgr", telescope.lsp_references, "[G]o to [r]eferences")

        vim.keymap.set("n", "<leader>rr", function()
            return ":IncRename " .. vim.fn.expand("<cword>")
        end, { expr = true, desc = "LSP: [R]ename under cursor" })
        bind("<leader>rn", ":IncRename ", "[R]e[n]ame to")
        bind("<leader>rR", buf.rename, "[R]ename (non-incremental)")

        bind("gy", buf.type_definition, "[G]o to t[y]pe definition")
        bind("gY", function() buf.typehierarchy("supertypes") end, "[G]o to supert[y]pes")
        bind("<leader>lgy", telescope.lsp_type_definitions, "[F]ind t[y]pe definitions")

        bind("<leader>S", telescope.lsp_dynamic_workspace_symbols, "Search [S]ymbols in this workspace")
        bind("<leader>lS", function() buf.workspace_symbol() end, "Search [S]ymbols in this workspace")
        bind("<leader>fs", telescope.lsp_workspace_symbols, "Search [S]ymbols in this workspace (once)")

        if capabilities.documentFormattingProvider then
            local fmt_opts = {
                bufnr = bufnr,
                async = false,
            }

            local function format()
                buf.format(fmt_opts)
            end

            vim.api.nvim_buf_create_user_command(bufnr, "Format", format, { desc = "Format file with LSP" })

            bind("<leader>lf", format, "[L]sp: [F]ormat")
            bind("<leader>lf", format, "[L]sp: [F]ormat", "v")

            bind("<leader>lF", function()
                vim.g.autoformat_disabled = not vim.g.autoformat_disabled
                vim.notify("Autoformat: " .. vim.inspect(not vim.g.autoformat_disabled))
            end, "Toggle [L]sp [F]ormat on save")

            local auto_group = "lsp_auto_format_" .. bufnr
            vim.api.nvim_create_augroup(auto_group, { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                desc = "Auto format buffer " .. bufnr .. " before save",
                group = auto_group,
                buffer = bufnr,
                callback = function()
                    if not vim.g.autoformat_disabled then
                        buf.format(fmt_opts)
                    end
                end,
            })
        end

        if capabilities.documentHighlightProvider then
            local highlight_name = "lsp_document_highlight_" .. bufnr
            vim.api.nvim_create_augroup(highlight_name, {})
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = highlight_name,
                buffer = bufnr,
                callback = buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                group = highlight_name,
                buffer = bufnr,
                callback = buf.clear_references,
            })
        end
    end

    return on_attach
end

return M

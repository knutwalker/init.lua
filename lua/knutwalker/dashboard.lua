local function init()
    local mode = vim.api.nvim_get_mode().mode
    if mode == "i" or not vim.bo.modifiable then
        return
    end

    local winid = vim.api.nvim_get_current_win()
    local win_width = vim.api.nvim_win_get_width(winid)
    local win_height = vim.api.nvim_win_get_height(winid)

    local btw = "I use neovim, btw"
    local btw_width = math.floor((win_width - string.len(btw)) / 2)
    local btw_height = math.floor(win_height / 2)

    local lines = {}
    for _ = 1, btw_height - 1 do
        table.insert(lines, {})
    end

    table.insert(lines, { { string.rep(" ", btw_width) }, { btw, "Bold" } })

    local ns = vim.api.nvim_create_namespace("btw")
    local mark = vim.api.nvim_buf_set_extmark(0, ns, 0, btw_width, {
        virt_lines = lines,
        hl_mode = "combine",
        strict = false,
        spell = false,
    })

    local g = vim.api.nvim_create_augroup("neovim-btw-buf", {})
    local buf_id = vim.api.nvim_get_current_buf()
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufLeave" }, {
        group = g,
        buffer = buf_id,
        callback = function()
            vim.api.nvim_buf_del_extmark(buf_id, ns, mark)
        end,
    })
end

local M = {}
M.setup = function()
    local g = vim.api.nvim_create_augroup("neovim-btw", { clear = true })
    local read_from_stdin = false

    vim.api.nvim_create_autocmd("StdinReadPre", {
        group = g,
        callback = function()
            read_from_stdin = true
        end,
    })

    vim.api.nvim_create_autocmd("UIEnter", {
        group = g,
        callback = function()
            if
                vim.fn.argc() == 0
                and vim.api.nvim_buf_get_name(0) == ""
                and read_from_stdin == false
            then
                init()
            end
        end,
    })
end

return M

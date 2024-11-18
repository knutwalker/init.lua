-- set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local bind = vim.keymap.set

-- Intent lines while keeping visual selection
bind("v", "<", "<gv", { desc = "Indent lines in" })
bind("v", ">", ">gv", { desc = "Indent lines out" })

-- join lines with J while keeping the cursor at the beginning
-- join lines with C-j to move the cursor to the end
bind("n", "J", "mzJ`z", { desc = "Join lines" })

-- jumping around but keep the cursor in the middle
bind("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
bind("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
bind("n", "n", "nzzzv", { desc = "Next search result" })
bind("n", "N", "Nzzzv", { desc = "Previous search result" })

-- don't yank on paste
bind({ "n", "v", "x" }, "d", '"_d', { desc = "Paste into the unnamed register" })
bind({ "n", "v", "x" }, "D", '"_D', { desc = "Paste into the unnamed register" })
bind({ "n", "v", "x" }, "<localleader>d", 'd', { desc = "Paste" })
bind({ "n", "v", "x" }, "<localleader>D", 'D', { desc = "Paste" })

-- yank and paste to and from the system clipboard
bind("n", "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
bind("v", "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
bind("n", "<leader>Y", '"+Y', { desc = "[Y]ank to system clipboard" })

bind("n", "<leader>p", '"+p', { desc = "[P]aste from system clipboard" })
bind("v", "<leader>p", '"+p', { desc = "[P]aste from system clipboard" })
bind("n", "<leader>P", '"+P', { desc = "[P]aste from system clipboard" })
bind("v", "<leader>P", '"+P', { desc = "[P]aste from system clipboard" })

bind("n", "<leader>d", '"+d', { desc = "[D]elete to system clipboard" })
bind("v", "<leader>d", '"+d', { desc = "[D]elete to system clipboard" })

-- always trigger ESC when Ctrl-C is pressed
bind("i", "<C-c>", "<Esc>", { desc = "Trigger <ESC> also in visual insert mode", noremap = true })

-- use 0 to go to the first non-ws character
bind("n", "0", "^", { desc = "Go to first non-whitespace character" })

-- save in insert mode
bind("i", "<C-s>", "<CMD>:w<CR><ESC>")
bind("n", "<C-s>", "<CMD>:w<CR><ESC>")

-- Add undo break-points
bind("i", ",", ",<c-g>u")
bind("i", ".", ".<c-g>u")
bind("i", ";", ";<c-g>u")

-- snake_case, kebab-case, and camelCase compatible text objects as `s`
vim.keymap.set({ "o", "x" }, "as", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
vim.keymap.set({ "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')

-- Never press Q
bind("n", "Q", "<nop>")

-- Toggle dark/light mode
bind("n", "<leader>M`", function()
    require("knutwalker.colors").toggle()
end, { desc = "Toggle dark/light [M]ode" })

-- Search for selected word
bind(
    "n",
    "<leader>zs",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Search/Replace word under cursor" }
)

-- space escape to remove highlighting
bind("n", "<ESC>", ":nohl<CR>", { desc = "Remove highlighting" })

-- delete with space x without copying into register
bind("n", "x", '"_x', { desc = "[X] Delete without copying into register" })

-- space + and space - to increment/decrement
bind("n", "<leader>=", "<C-a>", { remap = true, desc = "Increment number" })
bind("n", "<leader>-", "<C-x>", { remap = true, desc = "Decrement number" })

-- switch to other buffer
bind("n", "<leader>`", ":e #<CR>", { desc = "Switch to other buffer" })

-- window management with space w in addition to C-w
bind("n", "<leader>w", "<C-w>", { desc = "Window management" })

-- tab management with space tab
bind("n", "<leader><tab><tab>", ":tabnew<CR>", { desc = "New tab" })
bind("n", "<leader><tab>n", ":tabn<CR>", { desc = "[N]ext tab" })
bind("n", "<leader><tab>p", ":tabp<CR>", { desc = "[P]revious tab" })
bind("n", "<leader><tab>]", ":tabn<CR>", { desc = "[N]ext tab" })
bind("n", "<leader><tab>[", ":tabp<CR>", { desc = "[P]revious tab" })
bind("n", "<leader><tab>f", ":tabfirst<CR>", { desc = "[F]irst tab" })
bind("n", "<leader><tab>l", ":tablast<CR>", { desc = "[L]ast tab" })
bind("n", "<leader><tab>c", ":tabclose<CR>", { desc = "[C]lose current tab" })
bind("n", "<leader><tab>x", ":tabclose<CR>", { desc = "Close current tab" })
bind("n", "<leader><tab><space>", ":tabs<CR>", { desc = "[L]ist all tabs" })

-- navigate the quickfix list
bind("n", "<leader>qn", ":cnext<CR>zz", { desc = "[N]ext quickfix item" })
bind("n", "<leader>qp", ":cprev<CR>zz", { desc = "[P]revious quickfix item" })
bind("n", "<leader>qo", ":copen<CR>", { desc = "[O]pen the quickfix list" })
bind("n", "<leader>qq", ":cclose<CR>", { desc = "[Q]uit quickfix list" })
bind("n", "<leader>qc", ":cc ", { desc = "Select an item from the quickfix list" })
bind("n", "<leader>qN", ":cnewer<CR>", { desc = "Newer quickfix list" })
bind("n", "<leader>qP", ":colder<CR>", { desc = "Older quickfix list" })

-- navigate the location list
bind("n", "<leader>ln", ":lnext<CR>zz", { desc = "[N]ext location item" })
bind("n", "<leader>lp", ":lprev<CR>zz", { desc = "[P]revious location item" })
bind("n", "<leader>lo", ":lopen", { desc = "[O]pen the location list" })
bind("n", "<leader>lq", ":lclose<CR>", { desc = "[Q]uit location list" })
bind("n", "<leader>ll", ":ll", { desc = "Select an item from the location list" })

-- search for the next git conflict marker
bind("n", "<leader>gH", "/<<<<<<CR>", { desc = "Search for the next git conflict marker" })

-- lazygit integration
bind("n", "<leader>ly", function()
    require("lazy.util").float_term({ "lazygit" }, {
        size = { width = 0.95, height = 0.95 },
        margin = { top = 0, right = 0, bottom = 0, left = 0 },
    })
end, { desc = "Open [l]az[y]git" })

-- git-coprs integration
bind("n", "<leader>gp", function()
    require("lazy.util").float_term({ "git-coprs" }, {
        border = "rounded",
        size = { width = 0.9, height = 0.9 },
        margin = { top = 0, right = 0, bottom = 0, left = 0 },
    })
end, { desc = "Open [G]ithub [P]Rs for selection with git-coprs" })

-- git-drive integration
local function git_drive(args)
    local cmd = { "git-drive" }
    for _, v in ipairs(args or {}) do
        table.insert(cmd, v)
    end
    require("lazy.util").float_term(cmd, {
        border = "rounded",
        size = { width = 0.75, height = 0.75 },
        margin = { top = 2, right = 2, bottom = 2, left = 2 },
    })
end

bind("n", "<leader>gvv", function()
    git_drive()
end, { desc = "Open git-dri[v]e" })

bind("n", "<leader>gva", function()
    git_drive({ "alone" })
end, { desc = "git-dri[v]e [a]lone" })

bind("n", "<leader>gvw", function()
    local cmd = { "with" }
    local navigator = vim.fn.input("git drive with ")
    for nav in string.gmatch(navigator, "[^%s]+") do
        if nav ~= "" then
            table.insert(cmd, nav)
        end
    end
    git_drive(cmd)
end, { desc = "git-dri[v]e [w]ith" })

-- sessionizer integration
bind("n", "<leader><leader>", function()
    require("lazy.util").float_term({ "sessionizer" }, {
        border = "rounded",
        size = { width = 0.75, height = 0.75 },
        margin = { top = 2, right = 2, bottom = 2, left = 2 },
    })
end, { desc = "Open Sessionizer" })

-- load or toggle supermaven
bind("n", "<leader>C", function()
    local loaded = ((require("lazy.core.config").plugins["supermaven-nvim"] or {})._ or {}).loaded
    if loaded == nil then
        require("lazy").load({ plugins = { "supermaven-nvim" }, wait = true, show = false })
    else
        vim.cmd("SupermavenToggle")
    end
end, { desc = "Toggle Supermaven" })

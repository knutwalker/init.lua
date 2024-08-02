local opt = vim.o

-- big cursor in insert mode
opt.guicursor = "n-v-c-sm:hor100,i-ci-ve:ver25,r-cr-o:block"
-- highlight line with cursor
opt.cursorline = true

-- line numbers
opt.number = true
opt.relativenumber = true

-- 4 space indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- disable line wrapping
opt.wrap = false

-- undo over backups
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.undofile = true

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- pretty and dark colors
opt.termguicolors = true
opt.background = "dark"

-- show whitespace
opt.list = true
opt.listchars = "space:·,lead:·,trail:·,nbsp:☐,tab:▸ ,extends:❯,precedes:❮"

-- always show the sign column
vim.wo.signcolumn = "yes"

-- show columns at 80 and 120 width
opt.colorcolumn = "80,120"

-- Try to keep 8 lines at the bottom
opt.scrolloff = 8
-- Keep cursor line centered
-- opt.scrolloff = 9999

-- faster time to trigger CursorHold
opt.updatetime = 200

-- Faster timeout for mapped sequences, also when which-key is triggered
opt.timeoutlen = 500

-- allow backspace over autoindent, line breaks, and beyond start of insert
opt.backspace = "indent,eol,start"

-- always show completion menu and don't select automatically
opt.completeopt = "menu,menuone,noinsert,noselect,preview"

-- yank/paste to/from system clipboard
-- we do this with leader mappings instead
-- opt.clipboard:append('unnamedplus')

-- split windows to the right and down by default
opt.splitright = true
opt.splitbelow = true

-- include - when jumping over keywords e.g. with w or b
vim.opt.iskeyword:append("-")

-- Set proper sessionoptions according to https://github.com/rmagatti/auto-session/blob/08c279882d4117a3e6ade1a014f7cf4af7c34fec/README.md#recommended-sessionoptions-config
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Disable command line
opt.cmdheight = 0

-- Don't show the into messaage
vim.opt.shortmess:append({ I = true })

-- files 
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.swapfile = false

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- visual 
vim.opt.nu = true
vim.opt.relativenumber = true
vim.api.nvim_set_hl(0, "CursorLineNr", { bg="#222627" })
vim.opt.signcolumn = "yes:1"
vim.opt.wrap = true
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.colorcolumn = { 80 }
vim.api.nvim_set_hl(0, "ColorColumn", { bg="#222627" })
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { bg="#222627" })

-- qol 
vim.opt.incsearch = true
vim.opt.scrolloff = 24
vim.opt.updatetime = 100 -- (swapfile is off)
vim.opt.lazyredraw = true
vim.opt.timeoutlen = 700
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.iskeyword:append("-")
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.selection = "inclusive"
vim.opt.clipboard:append("unnamedplus")

-- keybindings
vim.g.mapleader = " "

-- i forgor
vim.keymap.set('n', '<J>', "mzJ`z")

-- easier highlight traverse
vim.keymap.set('n', "n", "nzzzv")
vim.keymap.set('n', "N", "Nzzzv")
vim.keymap.set('n', "<leader>*", ":noh<CR>")

-- no quit?
vim.keymap.set('n', "Q", "<nop>")

-- lsp completion
vim.keymap.set('i', '<c-space', function() vim.lsp.completion.get() end)

-- center cursor after page up/down
vim.keymap.set('n', "<C-d>", "<C-d>zz")
vim.keymap.set('n', "<C-u>", "<C-u>zz")

-- vscode like line movement
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

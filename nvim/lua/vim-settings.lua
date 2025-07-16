-- mem
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.swapfile = false

-- tabbings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- gui
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"
vim.opt.wrap = true
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.colorcolumn = { 80 }
vim.cmd("hi ColorColumn guibg=#212526")

-- qol 
vim.opt.incsearch = true
vim.opt.scrolloff = 24
vim.opt.updatetime = 50 -- (swapfile is off)

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

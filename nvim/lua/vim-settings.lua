-- files 
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.swapfile = false

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = false
vim.opt.smartindent = false

-- visual 
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"
vim.opt.wrap = true
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.colorcolumn = { 80 }
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cursorline = true

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
vim.opt.visualbell = true
vim.opt.selection = "inclusive"
vim.opt.clipboard:append("unnamedplus")

-- autocomplete
vim.opt.completeopt = {
    "noselect",
    "noinsert",
    "menuone",
}

-- keybindings
vim.g.mapleader = " "

-- i forgor
vim.keymap.set('n', "<J>", "mzJ`z")

-- easier highlight traverse
vim.keymap.set('n', "n", "nzzzv")
vim.keymap.set('n', "N", "Nzzzv")
vim.keymap.set('n', "ff", ":noh<CR>")

-- unnamed register dumb, use zero register for pasting
vim.keymap.set('n', "<C-p>", '"0p')
vim.keymap.set('v', "<C-p>", '"0p')

-- no quit?
vim.keymap.set('n', "Q", "<nop>")

-- lsp completion popup 
vim.keymap.set("i", "<C-p>", function()
    require("blink.cmp").show()
end)

-- center cursor after page up/down
vim.keymap.set('n', "<C-d>", "<C-d>zz")
vim.keymap.set('n', "<C-u>", "<C-u>zz")

-- vscode like line movement
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

-- split
vim.keymap.set('n', "<C-\\>", ":vsplit<CR><C-w>w")

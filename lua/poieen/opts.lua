-- set the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- enable line numbers and relative numbers
vim.opt.nu = true
vim.opt.rnu = true

-- set cursorline
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- set indent
vim.opt.tabstop = 8
vim.opt.softtabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false
-- colorscheme
vim.opt.termguicolors = true
vim.cmd.colorscheme[[habamax]]

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

-- backup, undo, etc.
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
vim.opt.isfname:append("@-@")

-- better, opinionated, searching mode
vim.opt.hlsearch = false
vim.opt.incsearch = true


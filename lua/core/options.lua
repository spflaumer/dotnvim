-- set (neo)vim options
-- rather opinionated, rather good (imo)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 2

vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.scrolloff = 10

vim.opt.termguicolors = true

vim.opt.backup = false
vim.opt.updatecount = 0
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("data").."_undos"
vim.opt.undofile = true

vim.opt.updatetime = 50
vim.opt.timeout = true
vim.opt.timeoutlen = 250

vim.opt.splitright = true
vim.opt.laststatus = 3
vim.opt.showmode = false

vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.shortmess:append("sI")

vim.opt.isfname:append("@-@")

vim.opt.clipboard = "unnamedplus"

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false


vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
vim.opt.isfname:append("@-@")

vim.opt.updatecount = 0
vim.opt.updatetime = 50

vim.opt.timeout = true
vim.opt.timeoutlen = 250

vim.opt.splitright = true

vim.opt.nu = true
vim.opt.rnu = true
vim.opt.nuw = 3
vim.opt.signcolumn = "yes"

vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.laststatus = 3
vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus"
vim.opt.shortmess:append("sI")
vim.opt.splitright = true

vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 10

require "core.bootstrap"
require "core.mappings"

-- set colorscheme
require("poieen.color")

-- set options
local opts = require("poieen.opts")
for scope, table in pairs(opts) do
	for setting, value in pairs(table) do
		vim[scope][setting] = value
	end
end

-- create basic keymap (basic neovim functions)
require("poieen.keymap.preplugin")

-- initialize lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({ "git", "clone",
                        "--filter=blob:none",
                        "https://github.com/folke/lazy.nvim",
                        lazypath
        })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
        defaults = { lazy = true },
})

require("poieen.config")
require("poieen.keymap.plugin")

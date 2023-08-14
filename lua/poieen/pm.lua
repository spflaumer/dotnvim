local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({ "git", "clone",
                        "--filter=blob:none",
                        "https://github.com/folke/lazy.nvim",
                        lazypath
        })
        if not vim.loop.fs_stat(lazypath) then
                print("lazy can't be installed")
                print("plugins unavailable")
                return
        end
end

vim.opt.rtp:prepend(lazypath)

local stat, lazy = pcall(require, "lazy")
if (not stat) then
        print("failed to require 'lazy'")
        print("plugins unavailable")
        return
end

lazy.setup("poieen.plugins", {})

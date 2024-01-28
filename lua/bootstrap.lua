local lazyp = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazyp) then
    vim.fn.system({
        "git", "clone", "https://github.com/folke/lazy.nvim",
        "--filter=blob:none", "--branch=stable", lazyp
    })
end

vim.opt.rtp:prepend(lazyp)

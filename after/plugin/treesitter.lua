local stat, ts_configs = pcall(require, "nvim-treesitter.configs")
if (not stat) then return end

ts_configs.setup {
        ensure_installed = { "php", "c", "lua", "javascript", "typescript", "html", "css", "zig" },
        sync_install = false,
        auto_install = true,
        highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
        }
}

vim.cmd[[TSUpdate]]

-- reduces the loading time by a few ms
-- neovim >= 0.9
if vim.version().minor >= 9 then
    vim.loader.enable()
end

require"core"

require"lazy".setup(require"plugins", require"plugins.configs.lazy")


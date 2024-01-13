-- using an if statement here results in 3ms longer loading times
-- omitting this completely increases the loading time by ~2ms
-- (on my machine using an i5-6300U)
(vim.loader or { enable = function()
    print("your neovim is older than v0.9: v"..vim.version().major.."."..vim.version().minor)
end }).enable()

require"core"

require"plugins"


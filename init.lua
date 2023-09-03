if vim.version().minor < 9 then
        print("neovim should be at least version 0.9")
        return
end

require("poieen")

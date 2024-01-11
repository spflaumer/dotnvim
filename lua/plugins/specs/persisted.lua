return {
    {
        "olimorris/persisted.nvim",
        lazy = false, -- autoload/save feature
        opts = function() return require "core.utils".config "persisted" end,
    }
}

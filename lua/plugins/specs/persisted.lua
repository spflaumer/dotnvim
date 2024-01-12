return {
    {
        "olimorris/persisted.nvim",
        init = function()
            require"core.utils".lazyLoad(function()
                vim.cmd[[SessionSave]]
            end, {"VimLeavePre"})
        end,
        cmd = { "SessionSave", "SessionLoad", "Telescope" },
        keys = { "<leader>s" },
        opts = function() return require "core.utils".config "persisted" end,
    }
}

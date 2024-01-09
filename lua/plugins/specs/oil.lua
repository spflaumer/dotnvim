return {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    opts = function()
        return require"core.utils".config "oil"
    end,
    config = function(_, opts)
        return require"oil".setup(opts)
    end
}

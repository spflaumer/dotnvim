return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = function() return require"core.utils".config "noice" end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "rcarriga/nvim-notify",
        opts = function() return require"core.utils".config "notify" end,
    }
}

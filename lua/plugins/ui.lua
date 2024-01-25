local config = require"config"

return {
    {
        "EdenEast/nightfox.nvim",
        opts = function()
            return config "nightfox"
        end,
        event = "UIEnter",
        config = function(_, opts)
            require"nightfox".setup(opts)
            vim.cmd[[colorscheme carbonfox]]
        end
    },
    {
        "rebelot/heirline.nvim",
        opts = function()
            return config "heirline"
        end,
        config = function(_, opts)
            require"heirline".setup(opts)
        end,
        event = "VeryLazy",
    },
}

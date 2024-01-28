local config = require"utils".config

return {
    {
        "EdenEast/nightfox.nvim",
        -- lazy = false,
        event = "UIEnter",
        opts = function()
            return config "nightfox"
        end,
        config = function(_, opts)
            require"nightfox".setup(opts)
            vim.cmd[[colorscheme carbonfox]]
        end
    },
    {
        "stevearc/Oil.nvim",
        event = "VeryLazy",
        opts = function()
            return config "oil"
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = function()
            return config "telescope"
        end,
        keys = {
            { "<leader>f", desc = "find" },
        },
        cmd = { "Telescope" }
    },
    {
        "rebelot/heirline.nvim",
        opts = function()
            return config "heirline"
        end,
        event = "VeryLazy",
    }
}

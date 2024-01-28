local config = require"config"

return {
    {
        "stevearc/Oil.nvim",
        event = "VeryLazy",
        opts = function()
            return config "oil"
        end,
        config = function(_, opts)
            require"oil".setup(opts)
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "Telescope" },
        keys = { "<leader>f", desc = "find" },
        -- this will be used to create keymaps
        opts = function()
            return config "telescope"
        end,
    }
}

local config = require"utils".config
local lazy_load = require"utils".lazy_load

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = function()
            return config "ibl"
        end,
        config = function(_, opts)
            require"ibl".setup(opts)
        end,
        init = function()
            lazy_load("indent-blankline.nvim")
        end 
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = function()
            return config "refactoring"
        end,
        keys = {
            { "<leader>r", mode = { "n", "x" }, desc = "refactor" },
        }
    },
    {
        "numToStr/Comment.nvim",
        opts = function()
            return config "comment"
        end,
        keys = {
            { "gc", mode = { "n", "v" }, desc = "comment" },
            { "gb", mode = { "n", "v" }, desc = "block comment" }
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufEnter",
        opts = function()
            return config "gitsigns"
        end,
    },
}
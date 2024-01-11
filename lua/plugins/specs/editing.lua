local lazyLoad = require"core.utils".lazyLoad
local config = require"core.utils".config

return {
    {
        "ThePrimeagen/refactoring.nvim",
        init = function() lazyLoad("refactoring.nvim") end,
        opts = function() return config "refactoring" end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        }
    },
    {
        "numToStr/Comment.nvim",
        init = function() lazyLoad("Comment.nvim") end,
        opts = function() return config "comment" end,
        keys = {
            { "gcc", mode = "n",          desc = "Comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n",          desc = "Comment toggle current block" },
            { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = function() return config "ibl" end,
        config = function(_, opts) require"ibl".setup(opts) end,
        init = function() lazyLoad("indent-blankline.nvim") end,
    }
}

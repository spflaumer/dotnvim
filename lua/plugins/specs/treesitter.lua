local lazyLoad = require"core.utils".lazyLoad

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function() return require"core.utils".config "treesitter" end,
        init = function()
            lazyLoad(function()
                require"lazy".load { plugins = "nvim-treesitter" }
            end)
        end,
        config = function(_, opts)
            require"nvim-treesitter.configs".setup(opts)
        end,
        build = ":TSUpdate",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-context",
                opts = function() require"core.utils".config "treesitter-context" end,
            },
            {
                "nvim-treesitter/nvim-treesitter-refactor",
                config = false,
            }
        }
    },
}

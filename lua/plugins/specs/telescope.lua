return {
    {
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        event = "VeryLazy",
        opts = function() require"core.utils".config "telescope" end,
        config = function(_, opts)
            require"telescope".setup(opts)
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-node-modules.nvim",
            "nvim-telescope/telescope-z.nvim",
            "cljoly/telescope-repo.nvim",
        },
    },
    {
        "nvim-telescope/telescope-node-modules.nvim",
        config = function() require"telescope".load_extension("node_modules") end,
    },
    {
        "nvim-telescope/telescope-z.nvim",
        config = function() require"telescope".load_extension("z") end,
    },
    {
        "cljoly/telescope-repo.nvim",
        config = function() require"telescope".load_extension("repo") end,
    }
}

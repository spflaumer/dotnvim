-- plugins for telescope.nvim
return {
    {
        "nvim-telescope/telescope-node-modules.nvim",
        config = function() require "telescope".load_extension("node_modules") end,
    },
    {
        "cljoly/telescope-repo.nvim",
        config = function() require "telescope".load_extension("repo") end,
    }
}

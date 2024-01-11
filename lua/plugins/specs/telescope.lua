return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        opts = function() require "core.utils".config "telescope" end,
        config = function(_, opts)
            require "telescope".setup(opts)
            require "telescope".load_extension "persisted"
            require "core.utils".nmap("<leader>sl", "<cmd>Telescope persisted<cr>", { desc = "load session" })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-node-modules.nvim",
            "nvim-telescope/telescope-z.nvim",
            "cljoly/telescope-repo.nvim",
            "olimorris/persisted.nvim",
        },
        keys = { "<leader>f", "<leader>sl", "<leader>g" },
        cmd = { "Telescope" },
    },
    {
        "nvim-telescope/telescope-node-modules.nvim",
        config = function() require "telescope".load_extension("node_modules") end,
    },
    {
        "nvim-telescope/telescope-z.nvim",
        config = function() require "telescope".load_extension("z") end,
    },
    {
        "cljoly/telescope-repo.nvim",
        config = function() require "telescope".load_extension("repo") end,
    }
}

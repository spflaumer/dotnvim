return {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    opts = function() return require"core.utils".config "harpoon" end,
    dependencies = { "nvim-lua/plenary.nvim" },
}

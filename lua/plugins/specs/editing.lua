return {
    {
        "ThePrimeagen/refactoring.nvim",
        event = "LspAttach",
        opts = function() return require"core.utils".config "refactoring" end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        }
    }
}

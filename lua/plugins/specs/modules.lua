return {
    {
        "nvim-lua/plenary.nvim",
        module = true,
    },
    {
        "neovim/nvim-lspconfig",
        module = true,
        config = function()
            vim.cmd[[silent! do FileType]]
        end,
    },
    {
        "ms-jpq/coq.thirdparty",
        opts = function() return require"core.utils".config "coq_3p" end,
        config = function(_, opts)
            require"coq_3p"(opts)
        end,
    },
    {
        "ms-jpq/coq.artifacts",
        module = true,
    },
    {
        "nvim-tree/nvim-web-devicons",
        module = true,
    }
}

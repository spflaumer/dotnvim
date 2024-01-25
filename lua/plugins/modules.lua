return {
    {
        "nvim-tree/nvim-web-devicons",
        module = true,
    },
    {
        "nvim-lua/plenary.nvim",
        module = true,
    },
    {
        "neovim/nvim-lspconfig",
        module = true,
        config = function()
            vim.cmd[[silent! do FileType]]
        end
    },
    {
        "ms-jpq/coq.artifacts",
        module = true,
    },
    {
        "ms-jpq/coq.thirdparty",
        opts = {
            { src = "bc", short_name = "MATH", precision = 6 },
        },
        config = function(_, opts)
            require"coq_3p"(opts)
        end
    }
}

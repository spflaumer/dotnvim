local config = require"config"

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            return config "nvim-treesitter"
        end,
        init = function()
            require"utils".lazyLoad(function()
                require"lazy".load {plugins = "nvim-treesitter"}
            end)
        end,
        config = function(_, opts)
            require"nvim-treesitter.configs".setup(opts)
        end,
        build = ":TSUpdate",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = function()
            return config "nvim-treesitter-context"
        end,
        init = function()
            require"utils".lazyLoad "nvim-treesitter-context"
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        }
    },

    {
        "williamboman/mason.nvim",
        opts = function()
            return config "mason"
        end,
        event = "VeryLazy",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require"config"("mason-lspconfig")
        end,
        init = function()
            require"utils".lazyLoad("mason-lspconfig.nvim", { "BufEnter" })
        end,
        dependencies = {
            "williamboman/mason.nvim",
        }
    },
    {
        "ms-jpq/coq_nvim",
        opts = function()
            return config "coq"
        end,
        build = ":COQdeps",
        config = function(_, opts)
            vim.api.nvim_set_var("coq_settings", opts)
            vim.cmd[[COQnow --shut-up]]
        end,
        dependencies = {
            "ms-jpq/coq.thirdparty",
            "ms-jpq/coq.artifacts",
        }
    }
}

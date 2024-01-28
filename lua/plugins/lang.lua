local config = require"utils".config
local lazy_load = require"utils".lazy_load

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            return config "treesitter"
        end,
        config = function(_, opts)
            require"nvim-treesitter.configs".setup(opts)
        end,
        build = ":TSUpdate",
        init = function()
            lazy_load(function()
                require"lazy".load {plugins = {"nvim-treesitter"}}
            end)
        end
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonLog",
            "MasonInstall", "MasonUninstall",
            "MasonUninstallAll", "MasonUpdate" },
        opts = function()
            return config "mason"
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = function()
            return config "mason-lspconfig"
        end,
    },
    {
        "neovim/nvim-lspconfig",
        init = function()
            lazy_load(function()
                vim.schedule(function() require"lazy".load {plugins = {"nvim-lspconfig"}} end)
                vim.cmd[[silent! do FileType]]
            end)
        end,
        opts = function()
            return config "lspconfig"
        end,
        config = function(_, opts)
            require"mason-lspconfig".setup_handlers(opts)
        end
    },
    {
        "ms-jpq/coq_nvim",
        opts = function()
            return config "coq"
        end,
        config = function(_, opts)
            vim.api.nvim_set_var("coq_settings", opts)
            vim.cmd[[COQnow --shut-up]]
        end,
        build = ":COQdeps",
        dependencies = {
            "ms-jpq/coq.artifacts",
            "ms-jpq/coq.thirdparty",
        }
    },
    {
        "ms-jpq/coq.thirdparty",
        opts = function()
            return config "coq_3p"
        end,
        config = function(_, opts)
            require"coq_3p"(opts)
        end,
    }
}

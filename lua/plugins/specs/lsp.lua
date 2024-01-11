local utils = require "core.utils"
local lazyLoad = utils.lazyLoad
local config = utils.config

return {
    -- lsp install and setup
    {
        "williamboman/mason.nvim",
        init = function()
            lazyLoad("mason.nvim")
        end,
        opts = function() return config "mason" end,
        config = function(_, opts)
            require "mason".setup(opts)
            -- lazy will run the `config` of mason-lspconfig
            -- which will in turn load nvim-lspconfig
            require "lazy".load { plugins = "mason-lspconfig.nvim" }

            -- this is really only a function just to setup mason-lspconfig,
            -- automatic server setup and consequently returns `nil`
            config "lsp"
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = function() return config "mason-lspconfig" end,
        config = function(_, opts)
            require "mason-lspconfig".setup(opts)
        end,
        dependencies = {
            "neovim/nvim-lspconfig",
            "folke/neodev.nvim",
        },
    },
    {
        "folke/neodev.nvim",
        opts = function() return config "neodev" end,
        config = function(_, opts)
            require "neodev".setup(opts)
        end,
    },
    -- completion and snippets
    -- TODO: "nvim-cmp source -> coq_nvim" glue
    {
        "ms-jpq/coq_nvim",
        cmd = { "COQnow", "COQdeps" },
        build = ":COQdeps",
        init = function()
            -- this has to be set before `require"coq"` is ever called,
            -- so it *has* to happen before any other lsp related setup
            vim.api.nvim_set_var("coq_settings", require "core.utils".config "coq")
        end,
        config = function()
            --remove the `--shut-up` to see a nice greeting
            vim.cmd [[COQnow --shut-up]]
        end,
        dependencies = {
            "ms-jpq/coq.thirdparty",
            "ms-jpq/coq.artifacts",
        }
    },
    -- improved LSP "ui"
    {
        "nvimdev/lspsaga.nvim",
        cmd = { "Lspsaga" },
        opts = function() return require "core.utils".config "lspsaga" end,
        config = function(_, opts)
            require "lspsaga".setup(opts)
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        }
    },
    {
        "stevearc/conform.nvim",
        opts = function() return require "core.utils".config "conform" end,
        config = function(_, opts)
            require "conform".setup(opts)
        end,
        init = function()
            lazyLoad("conform.nvim")
        end,
    }
}

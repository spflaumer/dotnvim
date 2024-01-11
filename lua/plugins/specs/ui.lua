return {
    {
        "EdenEast/nightfox.nvim",
        event = "VimEnter", -- make the colorscheme load sooner, but not too soon
        opts = function()
            return require "core.utils".config "nightfox"
        end,
        config = function(_, opts)
            require "nightfox".setup(opts)

            vim.cmd "colorscheme carbonfox"
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = function() return require "core.utils".config "noice" end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "rcarriga/nvim-notify",
        opts = function() return require "core.utils".config "notify" end,
    },
    {
        "nanozuki/tabby.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lualine/lualine.nvim"
        },
        opts = function() return require "core.utils".config "tabby" end,
        config = function(_, opts)
            require "tabby.tabline".use_preset("active_tab_with_wins", opts.tabline)
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "EdenEast/nightfox.nvim",
        },
        opts = function() return require "core.utils".config "lualine" end,
    }
}

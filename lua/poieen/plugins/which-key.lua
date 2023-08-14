return {{
        "folke/which-key.nvim",
        lazy = true, event = "VeryLazy",
        init = function()
                vim.opt.timeout = true
                vim.opt.timeoutlen = 275
        end,
        opts = {
                plugins = { spelling = { enabled = false } },
                window = { winblend = 10 },
                show_help = false,
        },
}}

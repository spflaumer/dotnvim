return {
        {
                "folke/which-key.nvim",
                init = function()
                        vim.opt.timeout = true
                        vim.opt.timeoutlen = 275
                end,
                opts = {
                        plugins = { spelling = { enabled = false } },
                        window = { winblend = 10 },
                        show_help = false,
                }
        },
        {
                "nvim-lua/plenary.nvim", module = true
        },
        {
                "theprimeagen/harpoon",
                opts = { global_settings = { tabline = true } },
                dependencies = { "nvim-lua/plenary.nvim" }
        },
        {
                -- autodetect indentation
                "tpope/vim-sleuth", event = "BufEnter"
        },
        {
                -- view all previous undos with branches when breaking changes occur
                "mbbill/undotree", event = "BufEnter"
        },
        {
                "nvim-treesitter/nvim-treesitter",
                config = function()
                        local stat, ts_configs = pcall(require, "nvim-treesitter.configs")
                        if (not stat) then return end

                        ts_configs.setup {
                                ensure_installed = { "php", "c", "lua", "javascript", "typescript", "html", "css", "zig" },
                                ignore_install = {},
                                sync_install = false,
                                auto_install = true,
                                highlight = {
                                enable = true,
                                        additional_vim_regex_highlighting = false,
                                },
                        }

                        vim.cmd[[TSUpdate]]
                end
        },
        {
                -- shows what function or data structure the current code is
                "nvim-treesitter/nvim-treesitter-context", event = "BufEnter"
        },
        {
                "theprimeagen/refactoring.nvim",
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        "nvim-treesitter/nvim-treesitter",
                },
                opts = {
                        prompt_func_return_type = {
                                cpp = true,
                                cxx = true,
                                hpp = true,
                                c = true,
                                h = true,
                        },
                        prompt_func_param_type = {
                                cpp = true,
                                cxx = true,
                                hpp = true,
                                c = true,
                                h = true,
                        }
                }
        },
        {
                "lukas-reineke/indent-blankline.nvim", main = "ibl",
                event = "BufEnter",
                opts = {
                       -- indent = { char = "┊" },
                       -- whitespace = { remove_blankline_trail = false },
                }
        },
        {
                "numToStr/Comment.nvim", event = "BufEnter",
                opts = {
                        toggler = {
                                line = "<leader>cc",
                                block = "<leader>cb",
                        },
                        opleader = {
                                line = "cc",
                                block = "cb",
                        },
                        extra = {
                                above = "<leader>cO",
                                below = "<leader>co",
                                eol = "<leader>cA",
                        },
                        mappings = {
                                basic = true,
                                extra = true,
                        }
                }
        },
        {
                "eandrju/cellular-automaton.nvim", module = true, -- don't load unless called by keybind
                init = function()
                        vim.keymap.set("n", "<leader>fml", function() require("cellular-automaton").start_animation("make_it_rain") end, { silent = true, noremap = true, desc = "watch the pain melt" })
                end
        },
        {
                "folke/trouble.nvim",
                dependencies = { "nvim-tree/nvim-web-devicons" },
                opts = {
                        icons = true,
                        signs = {
                                -- icons / text used for a diagnostic
                                error = "",
                                warning = "",
                                hint = "",
                                information = "",
                                other = "",
                        }
                }
        },
        {
                "nvim-telescope/telescope.nvim", branch = "0.1.x",
                dependencies = {
                        "nvim-lua/plenary.nvim"
                }
        },
        {
                "MunifTanjim/nui.nvim", module = true
        },
        {
                "rcarriga/nvim-notify", module = true
        },
        {
                "folke/noice.nvim",
                event = "VeryLazy",
                dependencies = {
                        "MunifTanjim/nui.nvim",
                        "rcarriga/nvim-notify"
                },
        }
}

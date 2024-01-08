return {
    {
        "stevearc/oil.nvim",
        cmd = { "Oil" },
        -- oil.nvim seems to hate getting deferred any more than this
        event = "VeryLazy",
        opts = require "plugins.configs.oil",
        config = function(_, opts)
            require "oil".setup(opts)
        end
    },
    {
        "EdenEast/nightfox.nvim",
        opts = require "plugins.configs.nightfox",
        config = function(_, opts)
            require "nightfox".setup(opts)
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
                callback = function()
                    local file = vim.fn.expand "%"
                    local cond = file:sub(1, 3) ~= "oil" and file ~= "[lazy]" and file ~= ""

                    if cond then return end

                    require "lazy".load { plugins = "nvim-treesitter" }
                end
            })
        end,
        opts = require "plugins.configs.treesitter",
        config = function(_, opts)
            require "nvim-treesitter.configs".setup(opts)
        end
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        opts = require "plugins.configs.mason",
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                    require "mason-lspconfig".setup(require "plugins.configs.mason".ensure_installed)
                end,
            },
        },
        config = function(_, opts)
            require "mason".setup(opts)
        end
    },
    {
        "neovim/nvim-lspconfig",
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
                callback = function()
                    local file = vim.fn.expand "%"
                    local cond = file:sub(1, 3) ~= "oil" and file ~= "[lazy]" and file ~= ""

                    if not cond then return end

                    vim.schedule(function()
                        require "lazy".load { plugins = "nvim-lspconfig" }
                        vim.cmd "silent! do FileType"
                    end)
                end
            })
        end,
        config = function()
            require "plugins.configs.lspconfig"
        end
    },
    {
        "nvimdev/guard.nvim",
        module = true,
        dependencies = {
            "nvimdev/guard-collection", module = true,
        },
    },
    {
        "nvimdev/lspsaga.nvim",
        module = true,
        cmd = { "Lspsaga" },
    },
    {
        "ms-jpq/coq_nvim",
        event = "InsertEnter",
        build = ":COQdeps",
        cmd = { "COQnow", "COQdeps" },
        init = function()
            vim.api.nvim_set_var("coq_settings", {
                display = {
                    ["ghost_text.context"] = { "<-", "" },
                    ["pum.source_context"] = { " from ", "" },
                },
                clients = {
                    ["tags.path_sep"] = " > ",
                    ["tree_sitter.path_sep"] = " > ",
                },
                limits = {
                    -- relax the timeouts a bit
                    completion_auto_timeout = 0.095,
                    completion_manual_timeout = 0.7,
                }
            })
        end,
        config = function()
            require "coq_3p" {
                { src = "nvimlua", short_name = "LUA",  conf_only = true },
                { src = "bc",      short_name = "MATH", precision = 6 },
            }
            vim.cmd "COQnow --shut-up"
        end,
        dependencies = {
            {
                "ms-jpq/coq.thirdparty",
                module = true,
            },
            {
                "ms-jpq/coq.artifacts",
                module = true,
            }
        }
    },
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gcc", mode = "n",          desc = "Comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n",          desc = "Comment toggle current block" },
            { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
        },
        init = function()
            local utils = require "core.utils"
            local mapn = utils.mapn
            local map = utils.map

            mapn("<leader>/", function() require "Comment.api".toggle.linewise.current() end, { desc = "toggle comment" })
            map("v", "<leader>/", '<ESC><cmd>lua require"Comment.api".toggle.linewise(vim.fn.visualmode())<CR>',
                { desc = "toggle comment" })
        end,
        config = function(_, opts)
            require "Comment".setup(opts)
        end
    },
    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g", "[", "]" },
        cmd = { "WhichKey" },
        opts = require "plugins.configs.whichkey",
        config = function(_, opts)
            require "which-key".setup(opts)
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
                callback = function()
                    local file = vim.fn.expand "%"
                    local cond = file:sub(1, 3) ~= "oil" and file ~= "[lazy]" and file ~= ""

                    if not cond then return end

                    vim.schedule(function()
                        require "lazy".load { plugins = "indent-blankline.nvim" }
                    end)
                end
            })

            -- implement jump to context
        end,
        opts = require "plugins.configs.ibl",
        config = function(_, opts)
            require "ibl".setup(opts)
        end
    },
    {
        "nvim-lua/plenary.nvim",
        module = true,
    },
    {
        "olimorris/persisted.nvim",
        keys = { "<leader>ss", "<leader>sl" },
        cmd = { "SessionSave", "SessionLoad" },
        config = function()
            require "persisted".setup { use_git_branch = true }

            require "core.utils".mapn("<leader>ss", function()
                vim.cmd "SessionSave"
                vim.notify((vim.bo.filetype ~= "oil" and vim.bo.filetype ~= "lazy" and vim.bo.filetype ~= "") and
                    "Session was Saved" or ("Can't save inside `" .. vim.bo.filetype .. "` filetype!"))
            end, { desc = "save session" })
            require "core.utils".mapn("<leader>sl", "<cmd>Telescope persisted<cr>", { desc = "load session" })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            -- useful plugins
            "nvim-telescope/telescope-node-modules.nvim",
            "nvim-telescope/telescope-z.nvim",
            "cljoly/telescope-repo.nvim",
            "olimorris/persisted.nvim",
            {
                "doctorfree/cheatsheet.nvim",
                keys = { "<leader>?" },
                config = function()
                    local ctact = require "cheatsheet.telescope.actions"

                    require "cheatsheet".setup {
                        bundled_cheatsheets = true,
                        bundled_plugin_cheatsheets = true,

                        include_only_installed_plugins = true,
                        telescope_mappings = {
                            ["<CR>"] = ctact.select_or_fill_commandline,
                            ["<A-CR>"] = ctact.select_or_execute,
                            ["<C-Y>"] = ctact.copy_cheat_value,
                            ["<C-E>"] = ctact.edit_user_cheatsheet,
                        }
                    }

                    require "core.utils".mapn("<leader>?", "<cmd>Cheatsheet<cr>", { desc = "cheatsheet" })
                end
            }
        },
        cmd = "Telescope",
        init = function()
            local utils = require "core.utils"
            local mapn = utils.mapn
            local c = utils.c

            mapn("<leader>ff", c "Telescope find_files", { desc = "find files" })
            mapn("<leader>fa", c "Telescope find_files follow=true no_ignore=true hidden=true",
                { desc = "find all files" })
            mapn("<leader>fl", c "Telescope live_grep", { desc = "live grep" })
            mapn("<leader>fz", c "Telescope current_buffer_fuzzy_find", { desc = "fuzzy find" })
            mapn("<leader>fh", c "Telescope help_tags", { desc = "help pages" })
            mapn("<leader>fp", c "Telescope oldfiles", { desc = "previously opened" })
            mapn("<leader>fb", c "Telescope buffers", { desc = "buffers" })
            mapn("<leader>fn", c "Telescope node_modules list", { desc = "node modules" })
            mapn("<leader>fr", c "Telescope repo list", { desc = "list repos" })

            mapn("<leader>gc", c "Telescope git_commits", { desc = "git commits" })
            mapn("<leader>gs", c "Telescope git_status", { desc = "git status" })

            mapn("<leader>tz", c "Telescope z list", { desc = "zoxide integration" })
        end,
        config = function()
            local opts = require "plugins.configs.telescope"
            local telescope = require "telescope"

            telescope.setup(opts)

            for _, ext in ipairs({ "node_modules", "z", "repo", "persisted" }) do
                require 'telescope'.load_extension(ext)
            end
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                callback = function()
                    vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" },
                        {
                            on_exit = function(_, return_code)
                                if return_code ~= 0 then return end

                                vim.schedule(function()
                                    require("lazy").load { plugins = { "gitsigns.nvim" } }
                                end)
                            end
                        }
                    )
                end,
            })
        end,
        opts = require "plugins.configs.gitsigns",
        config = function(_, opts)
            require "gitsigns".setup(opts)
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        module = true,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = require "plugins.configs.lualine",
        config = function(_, opts)
            require "lualine".setup(opts)
        end
    },
    {
        "nanozuki/tabby.nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        init = function()
            local mapn = require "core.utils".mapn

            mapn("<leader>ta", ":$tabnew<CR>", { desc = "new tab" })
            mapn("<leader>tc", ":tabclose<CR>", { desc = "close tab" })
            mapn("<leader>to", ":tabonly<CR>", { desc = "only tabs" })
            mapn("<leader>tn", ":tabn<CR>", { desc = "next tab" })
            mapn("<leader>tp", ":tabp<CR>", { desc = "prev tab" })
            mapn("<leader>tmp", ":-tabmove<CR>", { desc = "move tab back" })
            mapn("<leader>tmn", ":+tabmove<CR>", { desc = "move tab forward" })
        end,
        config = function()
            vim.opt.showtabline = 2

            require "tabby.tabline".use_preset("active_tab_with_wins", {
                nerdfont = true,
                lualine_theme = "auto",
                tab_name = {
                    name_fallback = function(tabid)
                        return tabid
                    end,
                },
                buf_name = { mode = "unique" },
            })
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = require "plugins.configs.noice",
        config = function(_, opts)
            require "noice".setup(opts)
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "MunifTanjim/nui.nvim",
        module = true,
    },
    {
        "rcarriga/nvim-notify",
        opts = {
            background_colour = "NotifyHighlight"
        },
        config = function(_, opts)
            vim.api.nvim_set_hl(0, "NotifyHighlight", { bg = "black", sp = "black" })
            require "notify".setup(opts)
        end,
        module = true,
    }
}

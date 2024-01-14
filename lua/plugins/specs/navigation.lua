-- plugins that help or add features
-- to all sorts of navigation within neovim
return {
    {
        "ggandor/leap.nvim",
        keys = { "s", "S", "gs" },
        dependencies = "tpope/vim-repeat",
        init = function()
            -- Hide the (real) cursor when leaping, and restore it afterwards.
            vim.api.nvim_create_autocmd('User', { pattern = 'LeapEnter',
                    callback = function()
                        vim.cmd.hi('Cursor', 'blend=100')
                        vim.opt.guicursor:append { 'a:Cursor/lCursor' }
                    end,
                }
            )
            vim.api.nvim_create_autocmd('User', { pattern = 'LeapLeave',
                    callback = function()
                        vim.cmd.hi('Cursor', 'blend=0')
                        vim.opt.guicursor:remove { 'a:Cursor/lCursor' }
                    end,
                }
            )
        end,
        config = function()
            require"leap".create_default_mappings(true)
        end
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        keys = {
            -- select buffers
            "<M-q>", "<M-w>", "<M-o>", "<M-p>",
            -- add to list and show list
            { "<leader>ha", desc = "add harpoon" }, { "<leader>he", desc = "show harpoons" },
            { "<leader>h[", desc = "prev harpoon" }, { "<leader>h]", desc = "next harpoon" }
        },
        config = function(_, opts)
            local harpoon = require"harpoon"

            harpoon:setup(opts)

            require"core.utils".mapping"harpoon"
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = { "Telescope" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
            { "<leader>fl", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
            { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "find in buffer" },
            { "<leader>fn", "<cmd>Telescope node_modules list<cr>", desc = "list of node modules" },
            { "<leader>fr", "<cmd>Telescope repo list<cr>", desc = "list repos" },

            { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "git commits" },
            { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "git status" },
        },
        -- make this a function, as otherwise
        -- require"telescope.xxx" will be ran before
        -- telescope is even loaded
        opts = function()
            return {
                defaults = {
                    vimgrep_arguments = {
                        "rg", "-L", "--color=never",
                        "--no-heading", "--with-filename",
                        "--line-number", "--column", "--smart-case",
                    },
                    prompt_prefix = " \u{f002}  ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "descending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "bottom",
                            preview_width = 0.6,
                            results_width = 0.8,
                        },
                        vertical = { mirror = false },
                        width = 0.9,
                        height = 0.8,
                        preview_cutoff = 120,
                    },
                    file_sorter = require"telescope.sorters".get_fuzzy_file,
                    file_ignore_patterns = { "node_modules", ".git", ".cache" },
                    generic_sorter = require"telescope.sorters".get_generic_fuzzy_sorter,
                    path_display = { "truncate" },
                    winblend = 30,
                    border = {},
                    borderchars = { "\u{2500}", "\u{2502}", "\u{2500}", "\u{2502}", "\u{250d}", "\u{250e}", "\u{2515}", "\u{2516}" },
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" },
                    file_previewer = require"telescope.previewers".vim_buffer_cat.new,
                    grep_previewer = require"telescope.previewers".vim_buffer_vimgrep.new,
                    qflist_previewer = require"telescope.previewers".vim_buffer_qflist.new,
                    buffer_previewer_maker = require"telescope.previewers".buffer_previewer_maker,
                    mappings = {
                        n = { ["q"] = require"telescope.actions".close },
                    }
                },
                extensions = {
                    repo = {
                        list = {
                            fd_opts = { "--no-ignore-vcs" },
                            search_dirs = { "~/Code" },
                        },
                    }
                }
            }
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-node-modules.nvim",
            "cljoly/telescope-repo.nvim",
            "olimorris/persisted.nvim",
        },
    }
}

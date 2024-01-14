-- plugins that impact the editor
-- or the editing experience
local lazyLoad = require"core.utils".lazyLoad
local mapping = require"core.utils".mapping

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        init = function()
            lazyLoad("indent-blankline.nvim")
        end,
        opts = {
            enabled = true,
            debounce = 50,
            exclude = {
                filetypes = {
                    "help",
                    "terminal",
                    "lazy",
                    "lspinfo",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "mason",
                    "oil",
                    "",
                },
                buftypes = { "terminal" },
            },
            whitespace = { remove_blankline_trail = true },
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
                highlight = { "Function", "Label" }
            }
        },
        config = function(_, opts) require"ibl".setup(opts) end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        cmd = { "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        init = function()
            lazyLoad(function()
                require"lazy".load {plugins = {"nvim-treesitter"}}
            end)
        end,
        opts = {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
        },
        config = function(_, opts)
            require"nvim-treesitter.configs".setup(opts)
        end
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        keys = {
            { "gcc", mode = "n",          desc = "Comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n",          desc = "Comment toggle current block" },
            { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
        }
    },
    {
        "ThePrimeagen/refactoring.nvim",
        cmd = "Refactor",
        keys = {
            { "<leader>ri", mode = {"n","x"}, desc = "inline variable" },
            { "<leader>rI", mode = "n", desc = "inline function" },
            { "<leader>re", mode = "x", desc = "extract variable" },
            { "<leader>rf", mode = "x", desc = "extract function" },
            { "<leader>rt", mode = "x", desc = "extract to file" },
            { "<leader>rb", mode = "n", desc = "extract block" },
            { "<leader>rB", mode = "n", desc = "extract block to file" },
        },
        opts = {},
        config = function(_, opts)
            require"refactoring".setup(opts)
            mapping("refactoring")
        end,
    },
}

local utils = require"core.utils"
local nmap = utils.nmap

local c = function(cmd) return "<cmd>Telescope "..cmd.."<cr>" end

return function()
    nmap("<leader>ff", c"find_files", { desc = "find files" })
    nmap("<leader>fl", c"live_grep", { desc = "live grep" })
    nmap("<leader>fz", c"current_buffer_fuzzy_find", { desc = "find in buffer" })
    nmap("<leader>fn", c"node_modules list", { desc = "list of node modules" })
    nmap("<leader>fr", c"repo list", { desc = "list repos" })

    nmap("<leader>gc", c"git_commits", { desc = "git commits" })
    nmap("<leader>gs", c"git_status", { desc = "git status" })

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
            sorting_strategy = "ascending",
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
end

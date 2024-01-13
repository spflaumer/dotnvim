-- plugins that change something in neovim"s UI
local map = require"core.utils".map

local c = function(cmd) return "<cmd>"..cmd.."<cr>" end

-- for autoupdating the tabby.nvim theme on colorscheme change
local function getColor(highlight, what)
    return string.format("#%.6x", vim.api.nvim_get_hl(0, { name = highlight, link = false })[what] or 0)
end

local function createTheme()
    return {
        fill = "TabLineFill",
        head = {
            bg = getColor("Special", "fg"),
            fg = getColor("TabLine", "bg"),
        },
        current_tab = {
            bg = getColor("Special", "fg"),
            fg = getColor("TabLine", "bg"),
        },
        tab = {
            bg = getColor("MoreMsg", "fg"),
            fg = getColor("TabLine", "bg"),
        },
        win = "TabLine",
        tail = "TabLine",
    }
end

return {
    {
        "stevearc/oil.nvim",
        event = "VeryLazy",
        opts = {
            default_file_explorer = true,
            columns = { "icon", "mtime" },
        },
        config = function(_, opts)
            map("n", "<leader>e", c"Oil", { desc = "files" })

            require"oil".setup(opts)
        end
    },
    {
        "rebelot/kanagawa.nvim",
        event = "VimEnter",
        opts = {
            transparent = false,
            theme = "dragon",
            background = {
                dark = "dragon",
                light = "wave",
            },
        },
        config = function(_, opts)
            require"kanagawa".setup(opts)
            vim.cmd[[colorscheme kanagawa]]
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        opts = { options = {
            transparent = false,
            number = 10,
            styles = {
                comments = "italic",
                keywords = "italic",
                statements = "bold",
            }
        }},
        config = function(_, opts)
            require"nightfox".setup(opts)
            vim.cmd[[colorscheme carbonfox]]
        end,
    },
    {
        "ms-jpq/chadtree",
        keys = {
            { "<leader>b", "<cmd>CHADopen<cr>", desc = "file tree" },
        },
        cmd = { "CHADopen", "CHADrestore", "CHADhelp", "CHADdeps" },
        build = ":CHADdeps",
        opts = {
            options = { show_hidden = true },
            view = { sort_by = { "is_folder", "file_name", "ext" } },
            keymap = {
                quit = { "q", "<Esc>" },
                refresh = { "<c-r>", "R" },
                change_focus_up = { "C", "cc" },
                secondary = { "<tab>" },
                tertiary = { "<S-Tab>", "<m-enter>" },
                collapse = { "<C-c>", "`" },
                new = { "n", "a" },
                link = { "N", "A" },
            },
        },
        config = function(_, opts)
            vim.api.nvim_set_var("chadtree_settings", opts)
        end
    },
    {
        "nanozuki/tabby.nvim",
        event = "UIEnter",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {},
        init = function()
            -- set different colors on theme reload
            vim.api.nvim_create_autocmd({"ColorScheme"}, {
                callback = function()
                    require"tabby.tabline".use_preset("active_tab_with_wins", { theme = createTheme() })
                end
            })
        end,
        config = function(_, opts)
            vim.opt.showtabline = 2
            require"tabby.tabline".use_preset("active_tab_with_wins", {
            theme = createTheme(),
            nerdfont = true,
            tab_name = {
                name_fallback = function(tabid)
                    return tabid
                end,
            },
            buf_name = { mode = "unique" },
        })
        end
    }
}

return {
    symbol_in_winbar = {
        enable = true,
        separator = " > ",
        show_file = false,
    },
    callhierarchy = {
        layout = "float",
        keys = { close = "<C-c>" },
    },
    code_action = {
        num_shortcut = true,
        show_server_name = true,
        keys = { quit = "<C-c>" },
    },
    definition = {
        width = 0.65,
        height = 0.45,
        keys = {
            edit = "<M-l>e",
            vsplit = "<M-l>v",
            split = "<M-l>s",
            tabe = "<M-l>t",
            quit = "<C-c>",
            close = "<M-l>k",
        },
    },
    diagnostic = {
        keys = {
            quit = "<C-c>",
            quit_in_show = { "q", "<C-c>" },
        }
    },
    finder = {
        default = "tyd+imp+def",
        keys = { close = "<C-c>" }
    },
    outline = {
        win_width = 50,
        keys = {
            quit = "<C-c>",
        }
    },
    rename = { keys = { quit = "<C-c>" } },
    ui = {
        code_action = "\u{ea61}",
        border = "rounded",
        expand = ">",
        collapse = "^",
    },
}

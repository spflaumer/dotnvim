return {
    symbol_in_winbar = {
        enable = true,
        separator = " > ",
        show_file = false,
    },
    callhierarchy = {
        layout = "float",
        keys = { close = "<C-k>" },
    },
    code_action = {
        num_shortcut = true,
        show_server_name = true,
        keys = { quit = "<C-k>" },
    },
    definition = {
        width = 0.65,
        height = 0.45,
        keys = {
            edit = "<M-l>e",
            vsplit = "<M-l>v",
            split = "<M-l>s",
            tabe = "<M-l>t",
            quit = "<C-k>",
            close = "<M-l>k",
        },
    },
    diagnostic = {
        keys = {
            quit = "<C-k>",
            quit_in_show = { "q", "<C-k>" },
        }
    },
    finder = {
        default = "tyd+imp+def",
        keys = { close = "<C-k>" }
    },
    outline = {
        win_width = 50,
        keys = {
            quit = "<C-k>",
        }
    },
    rename = { keys = { quit = "<C-k>" } },
    ui = {
        code_action = "\u{ea61}",
        border = "rounded",
        expand = ">",
        collapse = "^",
    },
}


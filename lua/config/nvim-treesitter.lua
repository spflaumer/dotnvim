-- nvim-treesitter-refactor
local refactor = {
    enable = true,
    highlight_definitions = {
        enable = true,
        clear_on_cursor_move = false,
    },
    hightlight_current_scope = { enabled = false },
    smart_rename = {
        enable = true,
        keymaps = { smart_rename = "gtr" },
    },
    navigation = {
        enable = true,
        keymaps = {
            goto_definition = "gtd",
            list_definitions = "gtD",
            list_definitions_toc = "gtO",
            goto_next_usage = "gtn",
            goto_previous_usage = "gtp",
        },
    }
}


return {
    ensure_installed = { "c", "lua", "vimdoc", "markdown", "markdown_inline" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
}


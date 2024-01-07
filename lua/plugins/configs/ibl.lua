return {
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
    }
}

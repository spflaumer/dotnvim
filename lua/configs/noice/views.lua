return {
    cmdline_popup = {
        position = { row = "10%", col = "50%" },
        size = { width = "60%", height = "auto" },
    },
    cmdline_popupmenu = {
        relative = "editor",
        position = {
            row = "27%", col = "50%",
        },
        border = {
            style = "rounded",
            padding = { 0, 1 },
        },
        size = { width = "61%", height = "auto" },
        win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        }
    },
    popupmenu = {
        relative = "cursor",
        border = {
            style = "rounded",
            padding = { 0, 1 },
        },
        win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
    },
    hover = {
        border = {
            style = "rounded",
            padding = { 0, 1 },
        },
        win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
    },
    split = {
        enter = true,
        concealcursor = {},
        conceallevel = 0,
    },
    vsplit = {
        enter = true,
        concealcursor = {},
        conceallevel = 0,
    },
}

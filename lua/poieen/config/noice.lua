local noice = require("noice")

noice.setup({
        health = { checker = false },
        lsp = {
                override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                }
        },
        cmdline = {
                enabled = true,
                format = {
                        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                },
        },
        views = {
                cmdline_popup = {
                        position = {
                                row = 3,
                                col = "50%",
                        },
                        size = {
                                width = "55%",
                                height = "auto",
                        },
                },
                popupmenu = {
                        relative = "editor",
                        position = {
                                row = 6,
                                col = "50%",
                        },
                        size = {
                                width = "50%",
                                height = 10,
                        },
                        border = {
                                style = "rounded",
                                padding = { 0, 1 },
                        },
                        win_options = {
                                winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                        }
                }
        },
        routes = {
                {
                        view = "split",
                        filter = {
                                any = {
                                        { event = "msg_show", min_height = 10 }
                                },
                        },
                },
                {
                        view = "mini",
                        filter = {
                                any = {
                                        { event = "msg_show", find = "written", kind = "" }
                                },
                        },
                },
        }
})


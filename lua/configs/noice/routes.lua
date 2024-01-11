return {
    {
        view = "cmdline_output",
        filter = { event = "msg_show", find = "1[:|.]" },
        opts = {
            size = "auto",
            close = { "<Esc>", "q" }
        }
    },
    {
        skip = true,
        filter = { find = "^[0-9]$" },
    },
    {
        view = "mini",
        filter = { event = "msg_show", kind = "", find = "written" },
    },
    {
        view = "mini",
        filter = { event = "msg_showmode", find = "record" },
        opts = { replace = true },
    }
}

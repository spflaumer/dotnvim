return function()
    vim.opt.showtabline = 2

    return {
        tabline = {
            nerdfont = true,
            lualine_theme = "auto",
            tab_name = {
                name_fallback = function(tabid)
                    return tabid
                end,
            },
            buf_name = { mode = "unique" },
        }
    }
end

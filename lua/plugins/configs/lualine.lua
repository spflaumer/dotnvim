-- original Bubbles config for lualina by lokesh-krishna (MIT License)
-- modified by spflaumer (MIT License)

return {
    options = {
        theme = "auto",
        component_separators = "|",
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = { "filename", "branch" },
        lualine_c = { "fileformat" },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
        },
    },
    tabline = {},
    extensions = {},
}

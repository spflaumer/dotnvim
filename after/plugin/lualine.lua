local filename = {
        "filename",
        newfile_status = true,
        path = 0,

        symbols = {
                modified = " ",
                readonly = "󱀰 ",
                unnamed = "󱀶 ",
                newfile = " ",
        },
}

local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic", "nvim_lsp", "nvim_workspace_diagnostic" },

        colored = true,
        update_in_insert = true,

        symbols = { error = " : ", warn = " : ", info = "󰘦 : ", hint = " : " },
}

local function utc_time()
        return os.date("%Y年%m月%d日 %H時%M分%S秒")
end

local function inactive_note()
        return "inactive"
end

local function active_note()
        return "active"
end

local stat, ll = pcall(require, "lualine")
if (not stat) then return end

ll.setup({
        options = {
                theme = "auto", --replace with "base16" soon
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
        },
        sections = {
                lualine_a = { "mode" },  -- add the onclick pop-up menu to change modes
                lualine_b = { filename, "location", diagnostics },
                lualine_c = { "branch" },
                lualine_x = { "progress" },
                lualine_y = { { "filetype", colored = false }, "fileformat", "encoding" },
                lualine_z = { active_note },
        },
        inactive_sections = {
                lualine_a = { "mode" },
                lualine_b = { filename, "location" },
                lualine_c = { "branch" },
                lualine_x = { "progress" },
                lualine_y = { },
                lualine_z = { inactive_note },
        },
        -- verify that this doesn't collide with bufferline.nvim
        --tabline = 
        --        lualine_a = { "buffers" },
        --        lualine_b = { "filename" },
        --        lualine_c = {},
        --        lualine_x = {},
        --        lualine_y = {},
        --        lualine_z = {},
        --
        tabline = {
                lualine_a = { "buffers" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { utc_time },
        }
})

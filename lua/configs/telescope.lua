local mapn = require"utils".keymap.mode_map("n")

local c = function(cmd) return "<cmd>Telescope "..cmd.."<CR>" end

mapn("<leader>ff", c"find_files", { desc = "find files" })
mapn("<leader>fz", c"current_buffer_fuzzy_find", { desc = "find text" })
mapn("<leader>fl", c"live_grep", { desc = "live grep" })
mapn("<leader>fs", c"spell_suggest theme=cursor", { desc = "spell suggestions" })

local lsp_cursor_adj = {
    vertical = { width = 0.5, height = 0.4 },
    horizontal = { width = 0.6, height = 0.4 },
}

return {
    defaults = {
        winblend = 30,
        path_display = { "truncate" },
        color_devicons = true
    },
    pickers = {
        lsp_references = { layout_config = lsp_cursor_adj },
        lsp_document_symbols = { layout_config = lsp_cursor_adj },
        lsp_definitions = { layout_config = lsp_cursor_adj },
        lsp_type_definitions = { layout_config = lsp_cursor_adj },
    }
}

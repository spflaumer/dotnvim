local function map(mode, lhs, rhs, opts)
    opts.remap = opts.remap or false

    vim.keymap.set(mode, lhs, rhs, opts)
end

local c = function(cmd) return "<cmd>Telescope "..cmd.."<CR>" end

map("n", "<leader>ff", c"find_files", { desc = "find files" })
map("n", "<leader>fz", c"current_buffer_fuzzy_find", { desc = "find text" })
map("n", "<leader>fl", c"live_grep", { desc = "live grep" })
map("n", "<leader>fs", c"spell_suggest theme=cursor", { desc = "spell suggestions" })

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

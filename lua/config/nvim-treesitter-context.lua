vim.keymap.set("n", "[c", function()
    require "treesitter-context".go_to_context(vim.v.count1)
end, { silent = true, desc = "goto context", noremap = true, remap = false })

return {
    enable = true,
    -- personally any more than this can be distracting
    multiline_threshold = 2,
    line_numbers = true,
}

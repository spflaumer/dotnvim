local map = function(mode, lhs, rhs, opts)
    opts.remap = opts.remap or false

    vim.keymap.set(mode, lhs, rhs, opts)
end

local c = function(cmd) return "<cmd>Refactor "..cmd.."<cr>" end

map("n", "<leader>ri", c"inline_var", { desc = "inline variable" })
map("n", "<leader>rI", c"inline_func", { desc = "inline function" })

map("x", "<leader>re", ":Refactor extract_var ", { desc = "extract var" })
map("x", "<leader>rf", ":Refactor extract ", { desc = "extract func" })
map("x", "<leader>rt", ":Refactor extract_to_file ", { desc = "extract to file" })

map("n", "<leader>rb", c"extract_block", { desc = "extract block" })
map("n", "<leader>rB", c"extract_block_to_file", { desc = "extract block to file" })

return {}

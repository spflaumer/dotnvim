local map = function(mode, lhs, rhs, opts)
    opts.noremap = opts.noremap or false

    vim.keymap.set(mode, lhs, rhs, opts)
end

local c = function(cmd) return "<cmd>"..cmd.."<CR>" end

map("n", "<leader>e", c"Oil", { desc = "files" })
map("n", "<leader>w", c"w", { desc = "save file" })
map("n", "<leader>q", c"q", { desc = "close"})

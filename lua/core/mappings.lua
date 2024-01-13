local map = require"core.utils".map

local c = function(cmd) return "<cmd>"..cmd.."<cr>" end

map("n", "<leader>w", c"w", { desc = "write file" })
map("n", "<leader>q", c"q", { desc = "quit neovim" })

-- tab navigation
map("n", "<M-[>", c"tabprev", { desc = "prev tab" })
map("n", "<M-]>", c"tabnext", { desc = "next tab" })

map("n", "<leader>tn", c"$tabnew", { desc = "new empty tab" })
map("n", "<leader>te", c"tabclose", { desc = "close tab" })

map("n", "[t", c"-tabmove", { desc = "prev tab position" })
map("n", "]t", c"+tabmove", { desc = "next tab position" })


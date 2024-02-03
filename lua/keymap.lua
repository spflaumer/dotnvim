local mapn = require"utils".keymap.mode_map("n")
local mapx = require"utils".keymap.mode_map("x")

local c = function(cmd) return "<cmd>"..cmd.."<cr>" end

mapn("<leader>e", c"Oil", { desc = "list files" })
mapn("<leader>w", c"w", { desc = "write" })
mapn("<leader>q", c"q", { desc = "quit nvim" })

mapx("K", ":m '<-2<CR>gv=gv", { desc = "line up" })
mapx("J", ":m '>+1<CR>gv=gv", { desc = "line down" })

mapn("<C-f>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "search and replace" })

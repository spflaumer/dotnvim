local mapn = require"core.utils".mapn
local map = require"core.utils".map
local c = require"core.utils".c

mapn("<leader>e", c"Oil", { desc = "files" })
mapn("<leader>w", c"w", { desc = "write buffer" })
mapn("<leader>q", c"q", { desc = "quit neovim" })

map({"n", "v"}, "<leader>d", '"_d', { desc = "delete to void" })

mapn("n", "nzzzv", { desc = "next result" })
mapn("N", "Nzzzv", { desc = "prev result" })

mapn("<M-r>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "search and replace" })


local utils = require"core.utils"
local nmap = utils.nmap

local function c(cmd) return "<cmd>"..cmd.."<cr>" end

nmap("<leader>w", c"w", { desc = "write file" })
nmap("<leader>q", c"q", { desc = "quit neovim" })

nmap("<leader>ta",  "<cmd>$tabnew<CR>", { desc = "new tab" })
nmap("<leader>tc",  "<cmd>tabclose<CR>", { desc = "close tab" })
nmap("<leader>to",  "<cmd>tabonly<CR>", { desc = "only tabs" })
nmap("<leader>tn",  "<cmd>tabn<CR>", { desc = "next tab" })
nmap("<leader>tp",  "<cmd>tabp<CR>", { desc = "prev tab" })
nmap("<leader>tmp", "<cmd>-tabmove<CR>", { desc = "move tab back" })
nmap("<leader>tmn", "<cmd>+tabmove<CR>", { desc = "move tab forward" })

local utils = require"core.utils"
local nmap = utils.nmap

local function c(cmd) return "<cmd>"..cmd.."<cr>" end

nmap("<leader>w", c"w", { desc = "write file" })
nmap("<leader>q", c"q", { desc = "quit neovim" })

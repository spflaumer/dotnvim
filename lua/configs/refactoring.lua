local utils = require"core.utils"
local nmap = utils.nmap
local map = utils.map

local c = function(cmd) return "<cmd>Refactor "..cmd.."<cr>" end

return function()
    nmap("<leader>ri", c"inline_var", { desc = "inline variable" })
    nmap("<leader>rI", c"inline_func", { desc = "inline function" })

    map("x", "<leader>re", ":Refactor extract_var ", { desc = "extract" })
    map("x", "<leader>rf", ":Refactor extract ", { desc = "extract variable" })
    map("x", "<leader>rt", ":Refactor extract_to_file ", { desc = "extract to file" })

    nmap("<leader>rb", c"extract_block", { desc = "extract block" })
    nmap("<leader>rB", c"extract_block_to_file", { desc = "extract block to file" })

    return {}
end




















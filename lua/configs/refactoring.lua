local utils = require"utils"
local mapn = utils.keymap.mode_map("n")
local mapx = utils.keymap.mode_map("x")

local c = function(cmd) return "<cmd>Refactor "..cmd.."<cr>" end

return function()
    print("mapped tho?")
    mapn("<leader>ri", c"inline_var", { desc = "inline variable" })
    mapn("<leader>rI", c"inline_func", { desc = "inline function" })

    mapx("<leader>re", ":Refactor extract_var ", { desc = "extract var" })
    mapx("<leader>rf", ":Refactor extract ", { desc = "extract func" })
    mapx("<leader>rt", ":Refactor extract_to_file ", { desc = "extract to file" })

    mapn("<leader>rb", c"extract_block", { desc = "extract block" })
    mapn("<leader>rB", c"extract_block_to_file", { desc = "extract block to file" })

    return {
        prompt_func_return_type = {
            go = true,
            java = true,

            cpp = true,
            cxx = true,
            hpp = true,
            c = true,
            h = true,
        },
        prompt_func_param_type = {
            go = true,
            java = true,

            cpp = true,
            cxx = true,
            hpp = true,
            c = true,
            h = true,
        },
    }
end

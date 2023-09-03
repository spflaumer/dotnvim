local function c(cmd)
        return "<cmd>" .. cmd .."<cr>"
end

local tbuiltin = require("telescope.builtin")

require("which-key").register({
        g = {
                name = "git",
                s = { c"Git", "git status" },
                c = { tbuiltin.git_commits, "git commits" },
                a = { tbuiltin.git_status, "git telescope status" },
        }
}, { noremap = true, remap = false, silent = true, prefix = "<leader>" })

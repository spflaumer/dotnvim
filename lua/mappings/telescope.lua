return function(map)
    local c = function(cmd) return "<cmd>Telescope "..cmd.."<cr>" end

    map("n", "<leader>ff", c"find_files", { desc = "find files" })
    map("n", "<leader>fl", c"live_grep", { desc = "live grep" })
    map("n", "<leader>fz", c"current_buffer_fuzzy_find", { desc = "find in buffer" })
    map("n", "<leader>fn", c"node_modules list", { desc = "list of node modules" })
    map("n", "<leader>fr", c"repo list", { desc = "list repos" })

    map("n", "<leader>gc", c"git_commits", { desc = "git commits" })
    map("n", "<leader>gs", c"git_status", { desc = "git status" })
end

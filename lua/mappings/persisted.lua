return function(map)
    map = map or require"core.utils".map

    map("n", "<leader>ss", "<cmd>SessionSave<cr>", { desc = "save session" })
    map("n", "<leader>sl", "<cmd>Telescope persisted<cr>", { desc = "list sessions" })
    map("n", "<leader>sL", "<cmd>SessionLoad<cr>", { desc = "load session" })
end

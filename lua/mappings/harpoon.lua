return function(map)
    map = map or require"core.utils".map

    map("n", "<leader>ha", function() require"harpoon":list():append() end, { desc = "add harpoon" })
    map("n", "<leader>he", function() require"harpoon".ui:toggle_quick_menu(require"harpoon":list()) end, { desc = "show harpoons" })

    map("n", "<M-q>", function() require"harpoon":list():select(1) end, { desc = "harpoon 1" })
    map("n", "<M-w>", function() require"harpoon":list():select(2) end, { desc = "harpoon 2" })
    map("n", "<M-o>", function() require"harpoon":list():select(3) end, { desc = "harpoon 3" })
    map("n", "<M-p>", function() require"harpoon":list():select(4) end, { desc = "harpoon 4" })

    map("n", "<leader>h]", function() require"harpoon":list():next() end, { desc = "next harpoon" })
    map("n", "<leader>h[", function() require"harpoon":list():prev() end, { desc = "prev harpoon" })
end

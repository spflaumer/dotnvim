local stat, mark = pcall(require, "harpoon.mark")
if (not stat) then return end

local status, ui = pcall(require, "harpoon.ui")
if (not status) then return end

local set = vim.keymap.set

set("n", "<leader>ha", mark.add_file, { desc = "add to harpoon" })
set("n", "<leader>ho", ui.toggle_quick_menu, { desc = "open harpoon" })

set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "first file" })
set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "second file" })
set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "third file" })
set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "fourth file" })
set("n", "<leader><tab>", ui.nav_next, { desc = "cycle files" })


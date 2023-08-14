local stat, builtin = pcall(require, "telescope.builtin")
if (not stat) then return end

local set = vim.keymap.set

set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "fuzzy find" })
set("n", "<leader>ff", builtin.find_files, { desc = "find files" })
set("n", "<leader>fg", builtin.git_files, { desc = "git files" })
set("n", "<leader>fs", function() builtin.grep_string({search = vim.fn.input("grep> ") }) end, { desc = "grep" })
-- add live_grep

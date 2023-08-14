local set = vim.keymap.set

set("x", "<leader>rf", function() vim.cmd("Refactor extract " .. vim.fn.input("function name: ")) end, { desc = "refactor extract" })
set("x", "<leader>rv", function() vim.cmd("Refactor extract_var " .. vim.fn.input("variable name: ")) end, { desc = "refactor variable" })

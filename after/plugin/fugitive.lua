local set = vim.keymap.set

set("n", "<leader>gs", vim.cmd.Git, { desc = "git status" })

-- add more mappings once i figure out how to sign commits from within nvim
-- (currently broken due to necessary `export GPG_TTY=$(tty)`)

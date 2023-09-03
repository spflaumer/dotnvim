return {
        {
                "tpope/vim-fugitive", event = "VeryLazy"
        },
        {
                "lewis6991/gitsigns.nvim", event = "BufEnter", -- find a way to create a "InGitDir" event
                opts = {
                        signs = {
                                add = { text = " " },
                                change = { text = " " },
                                delete = { text = " " },
                                topdelete = { text = "󰘣" },
                                changedelete = { text = " " },
                                untracked = { test = " " },
                        },
                        on_attach = function(bufnr)
                                local stat, gs = pcall(require, "gitsigns")
                                if (not stat) then
                                        print("gitsigns unavailable")
                                        return
                                end

                                vim.keymap.set("n", "<leader>gp", gs.prev_hunk, { buffer = bufnr, desc = "prev hunk" })
                                vim.keymap.set("n", "<leader>gn", gs.next_hunk, { buffer = bufnr, desc = "next hunk" })
                                vim.keymap.set("n", "<leader>gh", gs.preview_hunk, { buffer = bufnr, desc = "preview hunk" })
                        end,
                },
        },
}

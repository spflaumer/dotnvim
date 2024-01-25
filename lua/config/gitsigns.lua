return {
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
    },
    on_attach = function(bufnr)
        local mapn = function(lhs, rhs, opts)
            opts.remap = opts.remap or false

            vim.keymap.set("n", lhs, rhs, opts)
        end

        mapn("]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                require("gitsigns").next_hunk()
            end)
            return "<Ignore>"
        end, { desc = "next hunk", expr = true, buffer = bufnr })
        mapn("[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                require("gitsigns").prev_hunk()
            end)
            return "<Ignore>"
        end, { desc = "prev hunk", expr = true, buffer = bufnr })

        mapn("<leader>gr", function() require"gitsigns".reset_hunk() end, { desc = "reset hunk", buffer = bufnr })
        mapn("<leader>gp", function() require"gitsigns".preview_hunk() end, { desc = "preview hunk", buffer = bufnr })
        mapn("<leader>gb", function() package.loaded.gitsigns.blame_line() end, { desc = "blame line", buffer = bufnr })
        mapn("<leader>gd", function() require"gitsigns".toggle_deleted() end, { desc = "toggle deleted", buffer = bufnr })
    end,
}

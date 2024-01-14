return function(map)
    map = map or require"core.utils".map

    local c = function(cmd) return "<cmd>Lspsaga "..cmd.."<cr>" end

    map("n", "<leader>lci", c"incoming_calls", { desc = "incoming calls" })
    map("n", "<leader>lco", c"outgoing_calls", { desc = "outgoing calls" })

    map("n", "<leader>la", c"code_action", { desc = "code action" })

    map({"n", "i"}, "<M-d>", c"peek_definition", { desc = "definition" })
    map("n", "<leader>ld", c"goto_definition", { desc = "goto definition" })
    map({"n", "i"},"<M-t>", c"peek_type_definition", { desc = "type definition" })
    map("n", "<leader>lt", c"goto_type_definition", { desc = "goto type definition" })

    map("n", "[d", c"diagnostic_jump_prev", { desc = "lspsaga prev diag" })
    map("n", "]d", c"diagnostic_jump_next", { desc = "lspsaga next diag" })

    map("n", "<leader>lf", c"finder", { desc = "finder" })
    map({"n", "i"}, "<M-s>", vim.lsp.buf.hover, { desc = "hover" })

    map("n", "<leader>lo", c"outline", { desc = "overview" })

    map("n", "<leader>lr", c"rename", { desc = "rename" })
    map("n", "<leader>lrp", ":Lspsaga project_replace ", { desc = "project-wide rename" })
end

local stat, lsp = pcall(require, "lsp-zero")
if (not stat) then
        print("LSP failed to init!")
        return
end

lsp.preset("recommended")

lsp.ensure_installed({
        "phpactor"
})

lsp.nvim_workspace()


local stat, cmp = pcall(require, "cmp")
if (not stat) then
        print("completion unavailable")
        return
end

local cmp_select = {behaviour = cmp.SelectBehavior.Select}
local cmp_map = lsp.defaults.cmp_mappings({
        ["<C-i>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-o>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
        mapping = cmp_map
})

lsp.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
                error = "",
                warn = "",
                info = "󰘦",
                hint = "",
        }
})

lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", ".d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", ",d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require("neodev").setup({})

lsp.setup()


vim.diagnostic.config({
        virtual_text = true,
        update_in_insert = true,
})

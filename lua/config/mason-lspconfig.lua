-- setup lsp servers with mason-lspconfig.nvim
-- TODO: setup non-mason lsp's

local on_attach = function(_, bufnr)
    local nmap = function(mode, lhs, rhs, opts)
        opts.buffer = bufnr

        opts.remap = opts.remap or false

        vim.keymap.set(mode, lhs, rhs, opts)
    end

    local tc = function(cmd) return "<cmd>Telescope "..cmd.."<cr>" end

    nmap("n", "<leader>lf", tc"lsp_references theme=cursor", { desc = "references" })
    nmap("n", "<leader>ls", tc"lsp_document_symbols", { desc = "symbols in buffer" })
    nmap("n", "<leader>ld", tc"lsp_definitions theme=cursor", { desc = "definitions" })
    nmap("n", "<leader>lt", tc"lsp_type_definitions theme=cursor", { desc = "type definitions" })

    nmap("n", "[d", vim.diagnostic.goto_prev, { desc = "prev diag" })
    nmap("n", "]d", vim.diagnostic.goto_next, { desc = "next diag" })

    nmap("n", "<leader>la", vim.lsp.buf.code_action, { desc = "perform code actions" })
    nmap("n", "<M-;>", vim.lsp.buf.hover, { desc = "hover" })
    nmap({"n", "i"}, "<M-s>", vim.lsp.buf.signature_help, { desc = "func signature" })
    nmap("n", "<leader>lr", function() vim.lsp.buf.rename(nil) end, { desc = "rename symbol" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        }
    }
}


-- setup nicer borders for the lsp floats
vim.diagnostic.config {
    float = { border = "rounded" }
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "rounded"
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = "rounded"
    }
)


require"mason-lspconfig".setup_handlers {
    function(server)
        require"lspconfig"[server].setup(require"coq".lsp_ensure_capabilities {
            init_options = { documentFormatting = false },
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
    ["lua_ls"] = function()
        require"lspconfig".lua_ls.setup(require"coq".lsp_ensure_capabilities {
            on_attach = on_attach,
            settings = { Lua = {
                completion = { callSnippet = "Replace" }
            }},
            capabilities = capabilities,
        })
    end,
    ["zls"] = function()
        vim.api.nvim_set_var("zig_fmt_autosave", 0)

        require"lspconfig".zls.setup(require"coq".lsp_ensure_capabilities {
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
}

--clangd isn't officially supported on musl
require"lspconfig".clangd.setup(require"coq".lsp_ensure_capabilities {
    on_attach = on_attach,
    capabilities = capabilities,
})

return {}

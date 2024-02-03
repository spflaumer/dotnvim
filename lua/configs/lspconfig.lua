local on_attach = function(_, bufnr)
    local nmap = require"utils".keymap.mode_map("n", { buffer = bufnr })

    local tc = function(cmd) return "<cmd>Telescope "..cmd.."<cr>" end

    nmap("<leader>lf", tc"lsp_references theme=cursor", { desc = "references" })
    nmap("<leader>ls", tc"lsp_document_symbols", { desc = "symbols in buffer" })
    nmap("<leader>ld", tc"lsp_definitions theme=cursor", { desc = "definitions" })
    nmap("<leader>lt", tc"lsp_type_definitions theme=cursor", { desc = "type definitions" })

    nmap("[d", vim.diagnostic.goto_prev, { desc = "prev diag" })
    nmap("]d", vim.diagnostic.goto_next, { desc = "next diag" })

    nmap("<leader>la", vim.lsp.buf.code_action, { desc = "perform code actions" }, nil)
    nmap("<leader>lr", function() vim.lsp.buf.rename(nil) end, { desc = "rename symbol" })
    nmap("<M-;>", vim.lsp.buf.hover, { desc = "hover" }, "i")
    nmap("<M-s>", vim.lsp.buf.signature_help, { desc = "func signature" }, "i")
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
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                            [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
                            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                    completion = { callSnippet = "Replace" }
                },
            },
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

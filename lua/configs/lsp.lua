-- setup lsp servers with mason-lspconfig.nvim
-- TODO: setup non-mason lsp's

local utils = require"core.utils"
local _nmap = utils.nmap

local on_attach = function(_, bufnr)
    local nmap = function(lhs, rhs, opts, mode)
        opts.buffer = bufnr
        _nmap(lhs, rhs, opts, mode)
    end

    local c = function(cmd) return "<cmd>Lspsaga "..cmd.."<cr>" end

    nmap("<leader>lci", c"incoming_calls", { desc = "incoming calls" })
    nmap("<leader>lco", c"outgoing_calls", { desc = "outgoing calls" })

    nmap("<leader>la", c"code_action", { desc = "code action" })

    nmap("<M-d>", c"peek_definition", { desc = "definition" }, { "i" })
    nmap("<leader>ld", c"goto_definition", { desc = "goto definition" })
    nmap("<M-t>", c"peek_type_definition", { desc = "type definition" }, { "i" })
    nmap("<leader>lt", c"goto_type_definition", { desc = "goto type definition" })

    nmap("[d", c"diagnostic_jump_prev", { desc = "lspsaga prev diag" })
    nmap("]d", c"diagnostic_jump_next", { desc = "lspsaga next diag" })

    nmap("<leader>lf", c"finder", { desc = "finder" })
    nmap("<M-s>", vim.lsp.buf.hover, { desc = "hover" }, { "i" })

    nmap("<leader>lo", c"outline", { desc = "overview" })

    nmap("<leader>lr", c"rename", { desc = "rename" })
    nmap("<leader>lrp", ":Lspsaga project_replace ", { desc = "project-wide rename" })
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

return function()
    require"mason-lspconfig".setup_handlers {
        function(server)
            require"lspconfig"[server].setup(require"coq".lsp_ensure_capabilities {
                init_options = { documentFormatting = true },
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
        ["lua_ls"] = function()
            require"lspconfig".lua_ls.setup(require"coq".lsp_ensure_capabilities {
                before_init = require"neodev.lsp".before_init,
                init_options = { documentFormatting = true },
                on_attach = on_attach,
                settings = { Lua = {
                    completion = { callSnippet = "Replace" }
                }}
            })
        end,
    }
end


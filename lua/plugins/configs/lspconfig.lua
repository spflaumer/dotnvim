-- more NvChad inspiration drawn here

local coq = require"coq"

local on_attach = function(client, bufnr)
    if not vim.g.lspsaga_version then require"lspsaga".setup {
        ui = {
            expand = ">",
            collapse = "^",
            code_action = "\u{f0eb}",
        },
        lightbulb = { enabled = true },
        symbol_in_winbar = {
            enable = true,
        },
        callhierarchy = { keys = {
            close = "<C-k>",
        }},
        code_action = { keys = {
            quit = "<C-k>",
        }},
        implement = { enable = true },
        outline = { close_after_jump = true },
    } end

    local function map(mode, lhs, rhs, opts)
        local dopts = {
            noremap = true,
            buffer = bufnr,
        }
        for key, val in pairs(opts) do
            dopts[key] = val
        end

        vim.keymap.set(mode, lhs, rhs, dopts)
    end

    local function mapn(lhs, rhs, opts)
        map("n", lhs, rhs, opts)
    end

    local function c(cmd)
        return "<cmd>Lspsaga "..cmd.."<cr>"
    end

    mapn("<leader>lci", c"incoming_calls", { desc = "incoming calls"})
    mapn("<leader>lco", c"outgoing_calls", { desc = "outgoing calls"})

    mapn("<leader>la", c"code_action", { desc = "code actions" })

    map({"n", "i"}, "<M-p>d", c"peek_definition", { desc = "peek def" })
    map({"n", "i"}, "<M-p>t", c"peek_type_definition", { desc = "peek type" })

    map({"n", "i"}, "<M-g>d", c"goto_definition", { desc = "goto def" })
    map({"n", "i"}, "<M-g>t", c"goto_type_definition", { desc = "goto type" })

    mapn("[d", c"diagnostic_jump_prev", { desc = "prev diag" })
    mapn("]d", c"diagnostic_jump_next", { desc = "next diag" })

    mapn("<leader>lf", c"finder", { desc = "finder" })

    map({"n", "i"}, "<M-s>", c"hover_doc", { desc = "hover docs" })
    map({"n", "i"}, "<M-s>p", c"hover_doc ++keep", { desc = "hover docs (pin)" })

    map({"n", "i"}, "<M-o>", c"outline", { desc = "show code outline" })

    mapn("<leader>lr", c"lsp_rename", { desc = "rename" })
    mapn("<leader>lrp", c"lsp_rename ++project", { desc = "rename (project-wide)"})

    mapn("<leader>tt", "<cmd>Lspsaga term_toggle<cr>", { desc = "toggle term", buffer = 0 })
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
        },
    },
}

require"mason-lspconfig".setup_handlers {
    function (server_name)
        require("lspconfig")[server_name].setup(coq.lsp_ensure_capabilities{
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,

    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup(coq.lsp_ensure_capabilities{
            on_attach = on_attach,
            capabilities = capabilities,

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
                },
            },
        })
    end
}


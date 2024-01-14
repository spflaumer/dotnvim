-- anything related to LSP
local lazyLoad = require"core.utils".lazyLoad
local mapping = require"core.utils".mapping

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

local on_attach = function(_, bufnr)
    local map = function(mode, lhs, rhs, opts)
        opts.buffer = bufnr

        require"core.utils".map(mode, lhs, rhs, opts)
    end

    mapping("lsp", map)
end

return {
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonLog", "MasonUninstall" },
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "\u{f111}",
                    package_pending = "\u{f10c}",
                    package_uninstalled = "\u{f056}",
                },
            }
        },
    },
    {
        "neovim/nvim-lspconfig",
        module = true,
    },
    {
        "folke/neodev.nvim",
        opts = { lspconfig = false },
    },
    {
        "ms-jpq/coq_nvim",
        build = ":COQdeps",
        opts = {
            auto_start = "shut-up",
            ["match.look_ahead"] = 4,
            ["completion.skip_after"] = { "{", "}", "[", "]" },
            display = {
                ["ghost_text.context"] = { "<-", "" },
                ["pum.source_context"] = { "from ", "" },
                ["preview.positions"] = { east = 1, north = 2, south = 3, west = 4 },
            },
            clients = {
                lsp = {
                    weight_adjust = 1.4,
                    resolve_timeout = 0.65,
                },
                ["buffers.weight_adjust"] = 1,
                ["tree_sitter.enabled"] = true,
            },
            limits = {
                completion_auto_timeout = 0.092,
                completion_manual_timeout = 0.7,
            }
        },
        config = function(_, opts)
            vim.api.nvim_set_var("coq_settings", opts)

            lazyLoad(function() vim.cmd[[COQnow --shut-up]] end, { "LspAttach" })
        end,
        dependencies = {
            "ms-jpq/coq.thirdparty",
            "ms-jpq/coq.artifacts"
        }
    },
    {
        "ms-jpq/coq.thirdparty",
        opts = {
            { src = "bc", short_name = "MATH", precision = 6 },
            -- { src = "codeium", short_name = "COD" },
        },
        config = function(_, opts)
            vim.g.codeium_render = false

            require"coq_3p"(opts)
        end,
        -- dependencies = { "Exafunction/codeium.vim" }
    },
    -- currently not supported on musl
    -- {
    --    "Exafunction/codeium.vim",
    --    config = function()
    --        vim.api.nvim_set_var("codeium_disable_bindings", 1)
    --    end
    -- },
    {
        "williamboman/mason-lspconfig.nvim",
        init = function()
            lazyLoad("mason-lspconfig.nvim", {
                "BufEnter", "BufReadPre",
                "BufWinEnter", "BufNewFile"
            })
        end,
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "ms-jpq/coq_nvim",
        },
        -- for automatic server setup
        opts = {
            function(server)
                require"lspconfig"[server].setup(require"coq".lsp_ensure_capabilities {
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
            ["lua_ls"] = function()
                require"lspconfig".lua_ls.setup(require"coq".lsp_ensure_capabilities {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    before_init = require"neodev.lsp".before_init,
                    settings = { Lua = {
                        completion = { callSnippet = "Replace" },
                    }}
                })
            end
        },
        config = function(_, opts)
            require"mason-lspconfig".setup()
            require"mason-lspconfig".setup_handlers(opts)
            vim.cmd[[silent! do FileType]]
        end
    },
    {
        "nvimdev/lspsaga.nvim",
        opts = {
            symbol_in_winbar = {
                enable = true,
                separator = " > ",
                show_file = false,
            },
            callhierarchy = {
                layout = "float",
                keys = { close = "<C-k>" },
            },
            code_action = {
                num_shortcut = true,
                show_server_name = true,
                keys = { quit = "<C-k>" },
            },
            definition = {
                width = 0.65,
                height = 0.45,
                keys = {
                    edit = "<M-l>e",
                    vsplit = "<M-l>v",
                    split = "<M-l>s",
                    tabe = "<M-l>t",
                    quit = "<C-k>",
                    close = "<M-l>k",
                },
            },
            diagnostic = {
                keys = {
                    quit = "<C-k>",
                    quit_in_show = { "q", "<C-k>" },
                }
            },
            finder = {
                default = "tyd+imp+def",
                keys = { close = "<C-k>" }
            },
            outline = {
                win_width = 50,
                keys = {
                    quit = "<C-k>",
                }
            },
            rename = { keys = { quit = "<C-k>" } },
            ui = {
                code_action = "\u{ea61}",
                border = "rounded",
                expand = ">",
                collapse = "^",
            },
        },
        cmd = { "Lspsaga" },
    }
}

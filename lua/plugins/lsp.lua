return {{
        "VonHeikemen/lsp-zero.nvim", event = "BufEnter",
        branch = "v1.x",
        dependencies = {
                -- LSP Support
                {"neovim/nvim-lspconfig"},
                {"williamboman/mason.nvim"},
                {"williamboman/mason-lspconfig.nvim"},

                -- Autocompletion
                {"hrsh7th/nvim-cmp"},
                {"hrsh7th/cmp-buffer"},
                {"hrsh7th/cmp-path"},
                {"saadparwaiz1/cmp_luasnip"},
                {"hrsh7th/cmp-nvim-lsp"},
                {"hrsh7th/cmp-nvim-lua"},

                -- Snippets
                {"L3MON4D3/LuaSnip"},
                {"rafamadriz/friendly-snippets"},

                -- nvim lua_ls setup
                {"folke/neodev.nvim", opts = {}}
        },
        config = function()
                local stat, lsp = pcall(require, "lsp-zero")
                if (not stat) then
                        print("LSP failed to init!")
                        return
                end

                lsp.preset("recommended")

                lsp.ensure_installed({
                        "emmet_ls",
                        "tsserver",
                        "phpactor",
                        "lua_ls",
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
                        local opts = function(desc) return { buffer = bufnr, noremap = true, remap = false, desc = desc } end

                        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts"goto definition")
                        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts"hover")
                        vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.workspace_symbol() end, opts"workspace symbol")
                        vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts"open diagnostic float")
                        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts"goto next diag")
                        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts"goto previous diag")
                        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts"code action")
                        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts"references")
                        vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.rename() end, opts"rename")
                        vim.keymap.set("i", "<C-s>", function() vim.lsp.buf.signature_help() end, opts"signature")
                end)

                require("neodev").setup({})

                lsp.setup()

                vim.diagnostic.config({
                        virtual_text = true,
                })
        end
}}

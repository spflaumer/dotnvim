-- plugins that don't really fit a specific description
return {
    {
        "olimorris/persisted.nvim",
        opts = {
            use_git_branch = true,
            should_autosave = function()
                local file = vim.fn.expand("%")
                return (file:sub(1, 3) ~= "oil" and file ~= "[lazy]" and file ~= "")
            end,
        },
        init = function()
            vim.api.nvim_create_autocmd({"VimLeavePre"}, {
                callback = function()
                    vim.cmd[[SessionSave]]
                end
            })
        end,
        keys = {
            { "<leader>ss", desc = "save session" },
            { "<leader>sl", desc = "list sessions" },
            { "<leader>sL", desc = "load session" },
        },
        cmd = { "SessionSave", "SessionLoad", "Telescope persisted" },
        config = function(_, opts)
            require"core.utils".mapping("persisted", require"core.utils".map)

            require"persisted".setup(opts)
        end
    },
    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g", "[", "]" },
        cmd = { "WhichKey" },
        opts = {
            plugins = {
                marks = true,
                registers = true,
                spelling = { enabled = true, suggestions = 10 },
            },
            key_labels = {
                ["<leader>"] = "LDR",
                ["<space>"] = "SPC",
                ["<cr>"] = "RET",
                ["<tab>"] = "TAB",
            }
        },
        config = function(_, opts)
            require"which-key".setup(opts)
        end
    }
}

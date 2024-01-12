-- a collection of configs for all sorts of plugins
-- that were too short to create a dedicated config for

local m = {}

local nmap = require "core.utils".nmap

m.oil = function()
    nmap("<leader>e", "<cmd>Oil<cr>", { desc = "open files" })

    return {
        defualt_file_explorer = true,
        columns = { "icon", "mtime" },
    }
end

m.nightfox = {
    options = {
        transparent = true,
        styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
        }
    },
    specs = {
        all = {
            syntax = {
                number = "blue.dim"
            }
        }
    }
}

m["treesitter-context"] = function()
    nmap("[c", function()
        require "treesitter-context".go_to_context(vim.v.count1)
    end, { silent = true, desc = "goto context" })

    return {
        enable = true,
        -- personally any more than this can be distracting
        multiline_threshold = 2,
        line_numbers = true,
    }
end

m.neodev = {
    library = { plugins = true },
    lspconfig = false,
}

m["mason-lspconfig"] = {}

m["coq_3p"] = {
    { src = "bc", short_name = "MATH", precision = 6 }
}

m.coq = {
    display = {
        ["ghost_text.context"] = { "<-", "" },
        ["pum.source_context"] = { " from ", "" },
    },
    clients = {
        ["tags.path_sep"] = " > ",
        ["tree_sitter.path_sep"] = " > ",
        ["lsp.weight_adjust"] = 1.3,
        ["buffers.weight_adjust"] = 0.9,
    },
    limits = {
        completion_auto_timeout = 0.095,
        completion_manual_timeout = 0.7,
    },
}

m.notify = {
    background_colour = "#000000",
    fps = 24,
    render = "compact",
    stages = "fade",
}

m.comment = function()
    require "core.utils".nmap("<leader>/", function() require "Comment.api".toggle.linewise.current() end,
        { desc = "toggle comment" })
    require "core.utils".map("v", "<leader>/",
        '<ESC><cmd>lua require"Comment.api".toggle.linewise(vim.fn.visualmode())<CR>', { desc = "toggle comment" })

    return {}
end

m.ibl = {
    enabled = true,
    debounce = 50,
    exclude = {
        filetypes = {
            "help",
            "terminal",
            "lazy",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "mason",
            "oil",
            "",
        },
        buftypes = { "terminal" },
    },
    whitespace = { remove_blankline_trail = true },
    scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        highlight = { "Function", "Label" }
    }
}

m["which-key"] = {
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
}

m.persisted = function()
    require "core.utils".nmap("<leader>ss", "<cmd>SessionSave<cr>", { desc = "save session" })

    return {
        use_git_branch = true,
        autoload = false,
        autosave = true,
        should_autosave = function()
            local file = vim.fn.expand("%")
            return (file:sub(1, 3) ~= "oil" and file ~= "[lazy]" and file ~= "")
        end,
    }
end

m.cheatsheet = function()
    local ctact = require "cheatsheet.telescope.actions"
    require "core.utils".nmap("<leader>?", "<cmd>Cheatsheet<cr>", { desc = "cheatsheet" })

    return {
        bundled_cheatsheets = true,
        bundled_plugin_cheatsheets = true,

        include_only_installed_plugins = true,
        telescope_mappings = {
            ["<CR>"] = ctact.select_or_fill_commandline,
            ["<A-CR>"] = ctact.select_or_execute,
            ["<C-y>"] = ctact.copy_cheat_value,
            ["<C-e>"] = ctact.edit_user_cheatsheet,
        }
    }
end

return m

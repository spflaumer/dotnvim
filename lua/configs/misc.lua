local m = {}

m.nightfox = {
    options = { styles = {
        comments = "italic",
    }}
}

m.oil = {
    default_file_explorer = true,
    columns = { "icon", "mtime" },
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
            return name == ".git" or name == "." or name == ".."
        end
    }
}

m.treesitter = {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

    sync_install = false,
    auto_install = true,


    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
}

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

m.comment = {}

m.mason = {
    ui = {
        border = "rounded",
        icons = {
            package_pending = "\u{f192}",
            package_installed = "\u{f111}",
            package_uninstalled = "\u{eabd}",
        },
        keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            check_server_version = "c",
            update_all_servers = "U",
            check_outdated_servers = "C",
            uninstall_server = "X",
            cancel_installation = "<C-c>",
        }
    },
    max_concurrent_installers = 4,
}

m["mason-lspconfig"] = {}

m.coq = {
    auto_start = "shut-up",
    ["match.look_ahead"] = 4,
    ["completion.skip_after"] = { "{", "}", "[", "]" },
    display = {
        ["ghost_text.context"] = { "<-", "" },
        ["pum.source_context"] = { "from ", "" },
        ["preview.positions"] = { east = 1, north = 2, south = 3, west = 4 },
        ["preview.border"] = "rounded",
    },
    clients = {
        lsp = {
            weight_adjust = 1.4,
            resolve_timeout = 0.068,
        },
        ["buffers.weight_adjust"] = 1,
        ["tree_sitter.enabled"] = true,
    },
    limits = {
        completion_auto_timeout = 0.09,
        completion_manual_timeout = 0.62,
    }
}

m.coq_3p = {
    { src = "nvimlua", short_name = "nLUA", conf_only = true },
    { src = "bc", short_name = "MATH", precision = 6 },
}

return m

-- a collection of configs for all sorts of plugins
-- that were too short to create a dedicated config for

local m = {}

local nmap = require"core.utils".nmap

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
        require"treesitter-context".go_to_context(vim.v.count1)
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

return m

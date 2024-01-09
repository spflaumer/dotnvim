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

m["treesitter-refactor"] = {}

return m

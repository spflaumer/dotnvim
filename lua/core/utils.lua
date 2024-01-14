local m = {}

-- create a keymap
function m.map(mode, lhs, rhs, opts)
    opts.noremap = opts.noremap or false
    opts.silent = opts.silent or true

    vim.keymap.set(mode, lhs, rhs, opts)
end

-- lazy load a plugin when a certain event is fired
function m.lazyLoad(plugin, events)
    events = events or { "BufNewFile", "BufReadPre", "BufWinEnter" }

    vim.api.nvim_create_autocmd(events, { callback = function()
        if vim.bo.filetype == "oil" or vim.bo.filetype == "CHADtree" or vim.bo.filetype == "" then
            return
        end

        if type(plugin) == "string" then
            vim.schedule(function() require"lazy".load {plugins = {plugin}} end)
        elseif type(plugin) == "function" then
            plugin()
        else
            error(type(plugin) .. ". `function` or `string` expected")
        end
    end })
end

-- apply the predefined mappings of a plugin
function m.mapping(plugin, map)
    require("mappings."..plugin)(map)
end

return m

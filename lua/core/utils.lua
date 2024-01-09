local m = {}

-- create a keymap
-- noremap is set to false by default
function m.map(mode, lhs, rhs, opts)
    opts.noremap = opts.noremap or false

    vim.keymap.set(mode, lhs, rhs, opts)
end

-- create keymap for the normal mode and any other optionally added mode AS TABLE
function m.nmap(lhs, rhs, opts, mode)
    mode = mode or {}
    table.insert(mode, "n")

    m.map(mode, lhs, rhs, opts)
end

-- look into the configs directory and find a lua module named `config`
-- or a key named `config` within a table returned by a a misc.lua file
function m.config(config)
    -- TODO: 
    -- - expand function to set a custom configs directory
    -- - expand function to set a custom misc.lua filename

    local res, config_or_msg = pcall(require, "configs."..config)

    if res then
        return config_or_msg
    end

    -- possibly expand this to support a user supplied config file
    local misc = require"configs.misc"
    return misc[config] and misc[config] or error(config_or_msg)
end

-- lazy load a plugin
-- able to specify your own load function and events
function m.lazyLoad(plugin, events, loadf)
    events = events or { "BufEnterPre", "BufWinEnter", "BufNewFile" }
    loadf = loadf or function()
        require"lazy".load { plugins = plugin }
    end

    vim.api.nvim_create_autocmd(events, {
        callback = function(ev)
            if (ev.file == "" and ev.file == "[lazy]" and ev.file:sub(1,3) == "oil") then
                return
            end

            loadf(ev)
        end
    })
end

return m

local m = {}

-- remap disabled by default
function m.map(mode, lhs, rhs, opts)
    opts.remap = opts.remap or false
    opts.noremap = opts.remap or true

    vim.keymap.set(mode, lhs, rhs, opts)
end

-- return a function with a default mode
-- mode becomes the last argument and is optional
function m.mode_map(def_mode, def_opts)
    return function(lhs, rhs, opts, mode)
        mode = mode or {}
        if type(def_mode) == "string" then
            mode[#mode + 1] = def_mode
        end
        if type(def_mode) == "table" then
            for k,v in pairs(def_mode) do
                mode[k] = v
            end
        end

        opts = opts or {}

        if def_opts then for k,v in pairs(def_opts) do
            opts[k] = v
        end end

        m.map(mode, lhs, rhs, opts)
    end
end

return m

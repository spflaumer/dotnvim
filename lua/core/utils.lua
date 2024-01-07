local m = {}

function m.map(mode, lhs, rhs, opts)
    local dopts = { noremap = true }
    for key, val in pairs(opts) do
        dopts[key] = val
    end

    vim.keymap.set(mode, lhs, rhs, dopts)
end
function m.mapn(lhs, rhs, opts)
    m.map("n", lhs, rhs, opts)
end

function m.c(cmd)
    return "<cmd>"..cmd.."<cr>"
end

return m

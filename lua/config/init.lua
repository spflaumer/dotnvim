return function(plugin)
    local stat, mod = pcall(require, "config."..plugin)

    if not stat then
        error(mod)
    end

    return mod
end

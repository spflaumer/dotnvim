local part = function(p)
    return require("configs.noice."..p)
end


return {
    health = { checker = false },
    lsp = part"modules".lsp,
    views = part"views",
    routes = part"routes",
    throttle = 1000 / 60,
}

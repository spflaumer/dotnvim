local tab = {
    provider = function(_)
        return string.format("0x%0.2x", vim.api.nvim_get_current_tabpage())
    end
}

return {
    tab,
}

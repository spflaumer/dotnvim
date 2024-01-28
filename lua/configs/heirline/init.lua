local function setup_colors()
    local utils = require"heirline.utils"
    return {
        dark = "#111111",
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
        red = utils.get_highlight("DiagnosticError").fg,
        dark_red = utils.get_highlight("DiffDelete").bg,
        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        git_del = utils.get_highlight("DiagnosticError").fg,
        git_add = utils.get_highlight("String").fg,
        git_change = utils.get_highlight("Special").fg,
    }
end

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        require"heirline.utils".on_colorscheme(setup_colors)
    end,
    group = "Heirline",
})


local statusline = require"configs.heirline.statusline"
local winbar = require"configs.heirline.winbar"
-- local tabline = require"configs.heirline.tabline"

return {
    statusline = statusline,
    winbar = winbar,
    -- tabline = tabline,
    opts = {
        disable_winbar_cb = function(args)
            return require"heirline.conditions".buffer_matches({
                buftype = { "nofile", "prompt", "help", "quickfix" },
                filetype = { "^git.*", },
            }, args.buf)
        end,
        colors = setup_colors
    },
}

local utils = require"configs.heirline.utils"
local surround = utils.surround
local vimode_colors = utils.vimode_colors
local mode_color = utils.mode_color
local bg_follow_mode = utils.bg_follow_mode
local fg_follow_mode = utils.fg_follow_mode

local file = {
    init = function(self)
        self.icon, self.color = require"nvim-web-devicons".get_icon_color(vim.fn.expand "%:t", vim.fn.expand "%:e")
        self.name = vim.fn.expand "%:~"

        if type(self.icon) == "nil" or type(self.color) == "nil" then
            self.icon = "\u{e7c5} "
            self.color = self:mode_color()
        end
    end,
    {
        hl = function(self)
            return {
                fg = self.color,
                bg = "dark",
            }
        end,
        provider = function(self)
            return " "..self.icon.." "
        end
    },
    {
        provider = function(self)
            return self.name
        end,
        hl = function(_)
            return {
                fg = "bright_fg",
                bg = "dark"
            }
        end
    }
}


return {
    file,
    static = {
        vimode_colors = vimode_colors,
        mode_color = mode_color,
    }
}

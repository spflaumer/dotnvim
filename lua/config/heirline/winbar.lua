local utils = require"config.heirline.utils"
local surround = utils.surround
local vimode_colors = utils.vimode_colors
local mode_color = utils.mode_color
local fg_follow_mode = utils.fg_follow_mode

local fileicon = {
    init = function(self)
        local file = vim.fn.expand "%:t"
        local ext = vim.fn.expand "%:e"

        self.icon, self.color = require"nvim-web-devicons".get_icon_color(file, ext)
    end,
    provider = function(self)
        return (self.icon or "\u{e7c5}").." "
    end,
    hl = function(self)
        if self.color then
            return {
                bg = "dark",
                fg = self.color,
            }
        else
            return fg_follow_mode "dark"(self)
        end
    end
}

local filename = {
    provider = function()
        local file = vim.fn.expand "%:~"
        if #file > 0 then
            return file
        else
            return ""
        end
    end,
}

local tabid = {
    provider = function()
        local tabid = vim.api.nvim_get_current_tabpage()

        if type(tabid) == "number" then
            return string.format("0x%0.2x", tabid)
        else
            return tabid
        end
    end,
}

return {
    surround({" ", " "}, nil, { fileicon, filename }),
    { provider = "%=" },
    surround({" ", " "}, nil, tabid),

    static = {
        vimode_colors = vimode_colors,
        mode_color = mode_color,
    }
}


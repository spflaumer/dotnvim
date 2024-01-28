local m = {}

-- actually sane way of setting the highlights of delimiters
---@param delimeters string|string[]
---@param hl string|table|function|nil
---@param component table
function m.surround(delimeters, hl, component)
    component = require"heirline.utils".clone(component)

    local surround_color = function(self)
        if type(hl) == "function" then
            return hl(self)
        elseif type(hl) == "string" then
            return { fg = hl }
        else
            return hl
        end
    end

    local delim = function(delims)
        if type(delims) == "table" then
            return delims
        else
            return { delims, delims }
        end
    end

    local final_hl = function()
        return function(self)
            local s_color = surround_color(self)
            if s_color then return s_color end
        end
    end

    return {
        {
            provider = delim(delimeters)[1],
            hl = final_hl(),
        },
        component,
        {
            provider = delim(delimeters)[2],
            hl = final_hl(),
        }
    }
end


m.vimode_colors = {
    n = "blue",
    i = "green",
    v = "cyan",
    V = "cyan",
    ["\22"] = "cyan",
    c = "orange",
    s = "purple",
    S = "purple",
    ["\19"] = "purple",
    R = "orange",
    r = "orange",
    ["!"] = "red",
    t = "green",
}

m.mode_color = function(self)
    local mode = vim.fn.mode() or "n"
    return self.vimode_colors[mode]
end


m.bg_follow_mode = function(fg)
    return function(self)
        return {
            fg = fg,
            bg = self:mode_color(),
        }
    end
end

m.fg_follow_mode = function(bg)
    return function(self)
        return {
            bg = bg,
            fg = self:mode_color(),
        }
    end
end


return m

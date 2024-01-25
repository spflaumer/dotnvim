local utils = require"config.heirline.utils"
local surround = utils.surround
local vimode_colors = utils.vimode_colors
local mode_color = utils.mode_color
local bg_follow_mode = utils.bg_follow_mode
local fg_follow_mode = utils.fg_follow_mode

local mode = {
    provider = function(self)
        local mode = vim.fn.mode(1)

        return self.mode_map[mode]
    end,
    static = {
        mode_map = {
            ['n']      = 'NORMAL',
            ['no']     = 'O-PENDING',
            ['nov']    = 'O-PENDING',
            ['noV']    = 'O-PENDING',
            ['no\22'] = 'O-PENDING',
            ['niI']    = 'NORMAL',
            ['niR']    = 'NORMAL',
            ['niV']    = 'NORMAL',
            ['nt']     = 'NORMAL',
            ['ntT']    = 'NORMAL',
            ['v']      = 'VISUAL',
            ['vs']     = 'VISUAL',
            ['V']      = 'V-LINE',
            ['Vs']     = 'V-LINE',
            ['\22']   = 'V-BLOCK',
            ['\22s']  = 'V-BLOCK',
            ['s']      = 'SELECT',
            ['S']      = 'S-LINE',
            ['\19']   = 'S-BLOCK',
            ['i']      = 'INSERT',
            ['ic']     = 'INSERT',
            ['ix']     = 'INSERT',
            ['R']      = 'REPLACE',
            ['Rc']     = 'REPLACE',
            ['Rx']     = 'REPLACE',
            ['Rv']     = 'V-REPLACE',
            ['Rvc']    = 'V-REPLACE',
            ['Rvx']    = 'V-REPLACE',
            ['c']      = 'COMMAND',
            ['cv']     = 'EX',
            ['ce']     = 'EX',
            ['r']      = 'REPLACE',
            ['rm']     = 'MORE',
            ['r?']     = 'CONFIRM',
            ['!']      = 'SHELL',
            ['t']      = 'TERMINAL',
        }
    },
    hl = bg_follow_mode "dark",
}

local ruler = {
    provider = "%5(%l/%2L%):%2c %P",
    hl = bg_follow_mode "dark",
}

-- I take no credits for this! :lion:
local scroll ={
    static = {
        sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
    end,
    hl = fg_follow_mode "dark",
}

local diagnostics = {
    static = {
        error_icon = "E ",
        warn_icon = "W ",
        info_icon = "I ",
        hint_icon = "H ",
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    hl = {
        bg = "bright_bg",
    },
    {
        provider = function(self)
            return " "..self.error_icon..self.errors.." "
        end,
        condition = function(self) return self.errors > 0 end,
        hl = { fg = "diag_error" },
    },
    {
        provider = function(self)
            return " "..self.warn_icon..self.warns.." "
        end,
        condition = function(self) return self.warns > 0 end,
        hl = { fg = "diag_warn" }
    },
    {
        provider = function(self)
            return " "..self.hint_icon..self.hints.." "
        end,
        condition = function(self) return self.hints > 0 end,
        hl = { fg = "diag_hint" }
    },
    {
        provider = function(self)
            return " "..self.info_icon..self.info.." "
        end,
        condition = function(self) return self.info > 0 end,
        hl = { fg = "diag_info" }
    },
    {
        provider = " all good :) ",
        condition = function(self)
            return self.errors <= 0 and
                self.warns <= 0 and
                self.hints <= 0 and
                self.info <= 0
        end
    }
}

local separator = {
    provider = " ;",
    hl = {
        bg = "bright_bg",
        fg = "bright_fg"
    }
}

local git = {
    condition = require"heirline.conditions".is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0
        or self.status_dict.removed ~= 0
        or self.status_dict.changed ~= 0
    end,

    hl = {
        fg = "orange",
        bg = "bright_bg"
    },

    {
        provider = function(self)
            return " " .. self.status_dict.head
        end,
        hl = { bold = true }
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = "("
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count)
        end,
        hl = { fg = "git_add" },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count)
        end,
        hl = { fg = "git_del" },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count)
        end,
        hl = { fg = "git_change" },
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ")",
    },
    separator
}


local center = { provider = "%=" }

return {
    surround({"\u{2588}", "\u{e0b0}"}, fg_follow_mode "dark", mode),
    center,
    surround({"\u{e0b0}", "\u{e0b2}"}, { bg = "bright_bg", fg = "dark" }, { git, diagnostics }),
    center,
    surround({"\u{e0b2}", "\u{2588}"}, fg_follow_mode "dark", ruler),
    scroll,
    static = {
        vimode_colors = vimode_colors,
        mode_color = mode_color,
    }
}


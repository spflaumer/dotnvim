local utils = require"configs.heirline.utils"
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

local attached_lsp = {
    update = {'LspAttach', 'LspDetach'},

    provider = function()
        if not require"heirline.conditions".lsp_attached() then
            return " no LSP "
        end

        local names = {}
        for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        return " LSP [" .. table.concat(names, " ") .. "] "
    end,
    hl = { fg = "cyan", bg = "bright_bg" },
}

local diagnostics = {
    condition = require"heirline.conditions".has_diagnostics,

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
        self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    hl = { bg = "bright_bg" },

    {
        provider = " |"
    },
    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = "diag_error" },
    },
    {
        provider = function(self)
            return self.warns > 0 and (self.warn_icon .. self.warns .. " ")
        end,
        hl = { fg = "diag_warn" },
    },
    {
        provider = function(self)
            return self.infos > 0 and (self.info_icon .. self.infos .. " ")
        end,
        hl = { fg = "diag_info" },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = { fg = "diag_hint" },
    },
    {
        provider = "| "
    }
}

local git = {
    condition = require"heirline.conditions".is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = { fg = "orange", bg = "bright_bg" },

    {   -- git branch name
        provider = function(self)
            return "  " .. self.status_dict.head
        end,
        hl = { bold = true }
    },
    -- You could handle delimiters, icons and counts similar to Diagnostics
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
        provider = ") ",
    },
}

local ruler = {
    provider = "%5(%l/%2L%):%2c %P",
    hl = bg_follow_mode "dark",
}

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

local center = {
    provider = "%=",
    hl = { bg = "dark" }
}

return {
    utils.surround({"\u{2588}", "\u{e0b0}"}, fg_follow_mode("dark"), mode),
    center,
    utils.surround({"\u{e0b0}", "\u{e0b2}"}, { bg = "bright_bg", fg = "dark" },
        { git, attached_lsp, diagnostics }),
    center,
    utils.surround({"\u{e0b2}", ""}, fg_follow_mode "dark", { ruler, scroll }),

    static = {
        vimode_colors = vimode_colors,
        mode_color = mode_color,
    }
}

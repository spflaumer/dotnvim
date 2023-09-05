local utils = require("heirline.utils")
local cond = require("heirline.conditions")

local colors = {
        mode_fg = utils.get_highlight("ModeMsg").fg,
        mode_bg = utils.get_highlight("ModeMsg").bg,
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
        git_del = utils.get_highlight("diffRemoved").fg,
        git_add = utils.get_highlight("diffAdded").fg,
        git_change = utils.get_highlight("diffSubname").fg,
}

local mode = {
        init = function(self)
                self.mode = vim.fn.mode(1)
        end,

        provider = function(self)
                return " %7(" .. self.mode_names[self.mode] .. "%)"
        end,

        hl = function(self)
                return { fg = "mode_fg", bg = self:mode_color() }
        end,

        update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                        vim.cmd.redrawstatus()
                end),
        },

        static = {
                mode_names = {
                        ['n']      = 'NORMAL',
                        ['no']     = 'O-PENDING',
                        ['nov']    = 'O-PENDING',
                        ['noV']    = 'O-PENDING',
                        ['no\22']  = 'O-PENDING',
                        ['niI']    = 'NORMAL',
                        ['niR']    = 'NORMAL',
                        ['niV']    = 'NORMAL',
                        ['nt']     = 'NORMAL',
                        ['ntT']    = 'NORMAL',
                        ['v']      = 'VISUAL',
                        ['vs']     = 'VISUAL',
                        ['V']      = 'V-LINE',
                        ['Vs']     = 'V-LINE',
                        ['\22']    = 'V-BLOCK',
                        ['\22s']   = 'V-BLOCK',
                        ['s']      = 'SELECT',
                        ['S']      = 'S-LINE',
                        ['\19']    = 'S-BLOCK',
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
        }
}


local file = {
        init = function(self)
                self.fname = vim.api.nvim_buf_get_name(0)
                self.fext = vim.fn.fnamemodify(self.fname, ":e")
                self.fnmod = true
        end,
        hl = { bg = "mode_fg" }
}

local fileicon = {
        init = function(self)
                -- make sure not to crash the statusline if devicons fails to load
                local status, devicon = pcall(require, "nvim-web-devicons")
                if status then
                        self.icon, self.icon_color = devicon.get_icon_color(self.fname, self.fext, { default = true })
                else
                        self.icon = "NA"
                        self.icon_color = "#000000"
                end
        end,

        provider = function(self)
                return self.icon and (self.icon .. "  ")
        end,

        hl = function(self)
                return { fg = self.icon_color }
        end,
}

local filename = {
        provider = function(self)
                if self.fname == "" then return "[no name]" end

                local fname = (string.match(self.fname, vim.fn.getcwd()) and "./" .. vim.fn.fnamemodify(self.fname, ":.")) or vim.fn.fnamemodify(self.fname, ":~")
                if not cond.width_percent_below(#fname, 0.25) then
                        fname = vim.fn.pathshorten(fname)
                end

                return fname
        end,

        hl = ({ fg = "cyan", bold = true } and vim.bo.modified) or { fg = utils.get_highlight("Directory").fg },
}

local fileflags = {
        {
                provider = " ",
        },
        {
                provider = function()
                        return (vim.bo.modified and " ") or ""
                end,
                hl = { fg = "green" },
        },
        {
                provider = function()
                        return ((vim.bo.readonly and (not vim.bo.modifiable)) and " ") or ""
                end,
                hl = { fg = "orange" },
        }
}

file = utils.insert(file,
        fileicon,
        filename,
        fileflags,
        { provider = "%<" })

local git = {
        init = function(self)
                self.status_dict = vim.b.gitsigns_status_dict or { added = 0, removed = 0, changed = 0 }
                self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
        end,

        hl = { fg = "orange" },

        {
                -- branch name
                provider = function(self)
                        return " " .. self.status_dict.head .. " "
                end,
                hl = { bold = true },

                condition = function(self)
                        return self.has_changes
                end,
        },
        { condition = function(self) return self.has_changes end,
        utils.surround({ "(", ")"}, nil, {
        {
                provider = function(self)
                        local c = self.status_dict.added or 0
                        return c > 0 and ("+" .. c)
                end,
                hl = { fg = "git_add" }       
        },
        {
                provider = function(self)
                        local c = self.status_dict.removed or 0
                        return c > 0 and ("-" .. c)
                end,
                hl = { fg = "git_del" }
        },
        {
                provider = function(self)
                        local c = self.status_dict.changed or 0
                        return c > 0 and ("~" .. c)
                end,
                hl = { fg = "git_change" }
        }})},
        {
                provider = "![]",
                condition = function(self) return (not self.has_changes) end,
        }
}


local statusline = {
        utils.surround({"", " "}, function(self) return self:mode_color() end, mode),
        utils.surround({"", "  "}, function(self) return self:mode_color() end, file),
        utils.surround({"", "%="}, "mode_fg", git),

        static = {
                mode_colors = {
                        n = "mode_bg",
                        i = "green",
                        v = "cyan",
                        V =  "cyan",
                        ["\22"] =  "cyan",
                        c =  "orange",
                        s =  "purple",
                        S =  "purple",
                        ["\19"] =  "purple",
                        R =  "orange",
                        r =  "orange",
                        ["!"] =  "red",
                        t =  "red",
                },
                mode_color = function(self)
                        self.vimmode = cond.is_active() and vim.fn.mode() or self.vimmode
                        return self.mode_colors[self.vimmode]
                end,
        }
}


require("heirline").setup({
        statusline = statusline,
        opts = {
                colors = colors,
        }
})

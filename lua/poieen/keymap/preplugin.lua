local _set = vim.keymap.set

local function nnset(lhs, rhs, desc)
        _set("n", lhs, rhs, { noremap = true, remap = false, silent = true, desc = desc })
end

local function vnset(lhs, rhs, desc)
        _set("n", lhs, rhs, { noremap = true, remap = false, silent = true, desc = desc })
end

local function cnset(mode, lhs, rhs, desc)
        _set(mode, lhs, rhs, { noremap = true, remap = false, silent = true, desc = desc })
end

local function cnnsset(mode, lhs, rhs, desc)
        _set(mode, lhs, rhs, { noremap = true, remap = false, silent = false, desc = desc })
end

local function c(cmd)
        return "<cmd>" .. cmd .. "<cr>"
end

-- write and (force) quit
nnset("<leader>w", c"w", "write")
nnset("<leader>q", c"q", "quit")
nnset("<leader>Q", c"qa!", "force quit")

-- open netrw
nnset("<leader>fe", c"Ex", "netrw")

-- move to absolute start/start/end of line (normal mode)
cnset({ "n", "v" }, "<S-Left>", "0", "jmp absolute start of line")
cnset({ "n", "v" }, "<C-Left>", "^", "jmp start of line")
cnset({ "n", "v" }, "<C-Right>", "$", "jmp end of line")

-- same as above but in insert mode
cnset({ "i" }, "<S-Left>", "<C-o>0", "jmp absolute start of line")
cnset({ "i" }, "<C-Left>", "<C-o>^", "jmp start of line")
cnset({ "i" }, "<C-Right>", "<C-o>$", "jmp end of line")

-- move selected line up or down
vnset("K", ":m '<-2<CR>gv=gv", "move line up")
vnset("J", ":m '>+1<CR>gv=gv", "move line down")

-- join current line with line below
cnset({ "n", "v" }, "<C-j>", "mzJ`z", "join lines")
cnset("i", "<C-j>", "<C-o>mz<C-o>J<C-o>`z", "join lines") -- the cursor doesn't exactly return to it's original position (fix needed)

-- scroll half a page and center
cnset({ "n", "v" }, "<C-d>", "<C-d>zz", "scroll down centered")
cnset({ "n", "v" }, "<C-u>", "<C-u>zz", "scroll up centered")
cnset("i", "<C-Down>", "<C-d>zzi<Right>")
cnset("i", "<C-Up>", "<C-u>zzi<Right>")

-- improve search result lookup
cnset({ "n", "v" }, "N", "nzzzv", "next result")
cnset("i", "<C-n>", "<C-o>n<C-o>zz<C-o>zv", "next result")
cnset({ "n", "v" }, "n", "Nzzzv", "prev result")
cnset("i", "<M-n>", "<C-o>N<C-o>zz<C-o>zv", "prev result")

-- cut and paste
cnset({ "n", "v" }, "<leader>d", [["_d]], "delete to void")
cnset("x", "<leader>p", [["_dP]], "paste w/o overwrite reg")

-- yank to system clipboard
cnset({ "n", "v" }, "<leader>y", [["+y]], "yank to system clpbrd")

-- search and replace
cnnsset({ "n", "i" }, "<C-h>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "search and replace")
cnnsset({ "n", "i" }, "<M-h>", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "search and replace (current line)")

-- source the current file
nnset("<leader><leader>",  function() vim.cmd("so") end, "source this file")

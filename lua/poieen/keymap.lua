local set = vim.keymap.set

local function c(cmd)
        return "<cmd>" .. cmd .. "<cr>"
end

-- common keybinds
set("n", "<leader>w", c("w"), { desc = "write" })
set("n", "<leader>q", c("q"), { desc = "quit" })
set("n", "<leader>Q", c("q!"), { desc = "force quit" })
set("n", "<leader>W", c("w!"), { desc = "force write" })
set("n", "<leader>e", c("Ex"), { desc = "netrw" })

-- move to start or end of current line
set({"n", "v"}, "<C-Left>", "<cmd>lua vim.fn.feedkeys('^')<cr>", { desc = "goto line start" })
set({"n", "v"}, "<C-Right>", "<cmd>lua vim.fn.feedkeys('$')<cr>", { desc = "goto line end" })

-- move currently selected line up or down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "line down" })

-- join line below with current without moving the cursor
vim.keymap.set("n", "<leader>jl", "mzJ`z", { desc = "join lines" })

-- scroll while keeping the line with the cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "center-scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "center-scroll up" })

-- scroll through results
vim.keymap.set("n", "<leader>sn", "nzzzv", { desc = "next result" })
vim.keymap.set("n", "<leader>sp", "Nzzzv", { desc = "prev result" })

-- paste and delete wihtout overwriting the contents of the paste register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "better-paste"})
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "better-delete" })

-- yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "better yank" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "better Yank" })

-- quickfix list navigation
-- all items
vim.keymap.set("n", "<leader>xn", "<cmd>cnext<CR>zz", { desc = "next quickfix" })
vim.keymap.set("n", "<leader>xp", "<cmd>cprev<CR>zz", { desc = "prev quickfix" })
-- errors and warnings only
vim.keymap.set("n", "<leader>mn", "<cmd>lnext<CR>zz", { desc = "next warn/err" })
vim.keymap.set("n", "<leader>mp", "<cmd>lprev<CR>zz", { desc = "prev warn/err" })

-- search and replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "search and replace" })

-- source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "source" })

-- when things are rough
set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")


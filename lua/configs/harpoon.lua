local utils = require"core.utils"
local mapn = utils.nmap

return function()
    mapn("<leader>fh", function() require"harpoon.ui".toggle_quick_menu() end, { desc = "find harpoons" })
    mapn("<leader>ha", function() require"harpoon.mark".add_file() end, { desc = "mark file" })

    for i = 1, 4 do
        mapn("<M-"..i..">", function() require"harpoon.ui".nav_file(i) end, { desc = "nav to file "..i })
    end

    mapn("<M-e>", function() require"harpoon.ui".nav_next() end, { desc = "next file" })
    mapn("<M-q>", function() require"harpoon.ui".nav_prev() end, { desc = "prev file" })

    mapn("<M-t>", function() require"harpoon.term".gotoTerminal(1) end, { desc = "open terminal" })

    return {
        global_settings = { excluded_filetypes = { "harpoon", "" } },
        projects = {},
    }
end

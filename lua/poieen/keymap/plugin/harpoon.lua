local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

require("which-key").register({
        h = {
                name = "harpoon",
                a = { mark.add_file, "harpoon this file" },
                l = { ui.toggle_quick_menu, "list harpoons" },
                c = { mark.clear_all, "collect harpoons" },
                ["<tab>"] = { ui.nav_next, "cycle next" },
        }
        -- perhaps add shortcuts to files 1 through 5 or 6?
}, { remap = false, noremap = true, silent = true, prefix = "<leader>" })

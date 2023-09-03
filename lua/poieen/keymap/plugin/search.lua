local tbuiltin = require("telescope.builtin")

require("which-key").register({
        f = {
                name = "file",
                f = { tbuiltin.find_files, "find files" },
                g = { tbuiltin.git_files, "find git tracked files" },
        },
        s = {
                name = "search",
                b = { tbuiltin.current_buffer_fuzzy_find, "fuzzy find" },
                s = { tbuiltin.live_grep, "live grep" },
                g = { tbuiltin.grep_string, "grep" },
        }
}, { remap = false, noremap = true, silent = true, prefix = "<leader>" })

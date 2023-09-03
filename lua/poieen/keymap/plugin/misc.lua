local function c(cmd)
        return "<cmd>" .. cmd .. "<cr>"
end

-- enable refactoring extensions in telescope
require("telescope").load_extension("refactoring")
vim.keymap.set({ "n", "x" }, "<leader>rh",
        function() require("telescope").extensions.refactoring.refactors() end,
        { remap = false, noremap = true, silent = false, desc = "open in telescope" }
)

require("which-key").register({
        r = {
                name = "refactor",
                f = { c"Refactor extract", "extract to function" },
                F = { c"Refactor extract_to_file", "extract to file" },
                v = { c"Refactor extract_var", "create variable" },
                i = { c"Refactor inline_var", "replace variable" },
        }
}, { remap = false, noremap = true, silent = false, prefix = "<leader>", mode = "x" })

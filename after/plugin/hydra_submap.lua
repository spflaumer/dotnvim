local stat, Hydra = pcall(require, "hydra")
if (not stat) then
        print("hydra and subsequent submaps unavailable")
        return
end

Hydra({
        name = "Window Resize Submap",
        mode = { "n", "v" },
        body = "<leader>br",
        heads = {
                { "<Up>", "<cmd>resize +2<cr>", { desc = "increase height" }},
                { "<Down>", "<cmd>resize -2<cr>", { desc = "decrease height" }},
                { "<Left>", "<cmd>vertical resize +2<cr>", { desc = "increase width" }},
                { "<Right>", "<cmd>vertical resize -2<cr>", { desc = "decrease width" }},
                { "<Esc>", nil, { desc = "exit", exit_before = true }},
        },
        config = {
                exit = false,
                foreign_keys = "run",
                invoke_on_body = true,
                desc = "window resize (submap)",
        },
})

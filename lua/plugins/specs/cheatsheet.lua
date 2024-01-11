return {
    "doctorfree/cheatsheet.nvim",
    keys = { "<leader>?" },
    opts = function() return require"core.utils".config "cheatsheet" end,
}

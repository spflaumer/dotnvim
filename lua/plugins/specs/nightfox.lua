return {
    "EdenEast/nightfox.nvim",
    event = "UIEnter",  -- make the colorscheme load sooner, but not too soon
    opts = function()
        return require"core.utils".config"nightfox"
    end,
    config = function(_, opts)
        require"nightfox".setup(opts)

        vim.cmd"colorscheme carbonfox"
    end
}

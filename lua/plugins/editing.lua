return {
    {
        "numToStr/Comment.nvim",
        opts = {},
        keys = { "gc", "gb" },
    },
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            require"utils".lazyLoad(function()
                vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" },
                    {
                        on_exit = function(_, return_code)
                            if return_code ~= 0 then return end

                            vim.schedule(function()
                                require("lazy").load { plugins = "gitsigns.nvim" }
                            end)
                        end,
                    }
                )
            end, { "BufEnter", "BufWinEnter" })
        end,
        opts = function() return require"config" "gitsigns" end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = function()
            return require"config" "ibl"
        end,
        config = function(_, opts)
            require"ibl".setup(opts)
        end,
        event = "BufEnter",
    },
    {
        "ThePrimeagen/refactoring.nvim",
        opts = function()
            return require "config" "refactoring"
        end,
        event = "BufEnter",
    }
}

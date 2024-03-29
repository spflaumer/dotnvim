return {
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            require"core.utils".lazyLoad(function()
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
        opts = function() require"core.utils".config "gitsigns" end,
    }
}

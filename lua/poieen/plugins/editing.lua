return {
        {
                'lukas-reineke/indent-blankline.nvim', main = "ibl",
                -- Enable `lukas-reineke/indent-blankline.nvim`
                -- See `:help indent_blankline.txt`
                opts = {
                        indent = { char = '┊' },
                },
        },

        -- "gc" to comment visual regions/lines
        { 'numToStr/Comment.nvim', opts = {
                toggler = {
                        line = '<leader>cc',
                        block = '<leader>cb',
                },
                opleader = {
                        line = 'cc',
                        block = 'cb',
                },
                extra = {
                        above = '<leader>cO',
                        below = '<leader>co',
                        eol = '<leader>cA',
                },
                mappings = {
                        basic = true,
                        extra = true,
                },
        } },
}

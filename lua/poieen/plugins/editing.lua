return {
        {
                'lukas-reineke/indent-blankline.nvim',
                -- Enable `lukas-reineke/indent-blankline.nvim`
                -- See `:help indent_blankline.txt`
                opts = {
                        char = '┊',
                        show_trailing_blankline_indent = false,
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

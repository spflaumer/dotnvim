local options = {
	g = {
		-- leader key
		mapleader = " ",
		maplocalleader = " ",
	},
	opt = {
		-- enable line numbers and relative line numbers
		-- useful for motions
		nu = true,
		rnu = true,

		-- enable cursorline
		cursorline = true,
		cursorlineopt = "number",

		-- indentation
		tabstop = 8,
		softtabstop = 8,
		shiftwidth = 8,
		expandtab = true,

		autoindent = true,
		smartindent = true,

		-- disable wrapping of text wider than the screen
		wrap = false,

		-- how many lines will always be visible above and below the cursor
		scrolloff = 10,
		signcolumn = "yes",

		updatetime = 50,

		-- disable backups and swapfiles
		backup = false,
		swapfile = false,

		-- persist undo's
		undodir = vim.fn.stdpath("data") .. "/undo",
		undofile = true,

		-- better (opinionated) search highlighting setting
		hlsearch = false,
		incsearch = true,
	}
}

return options

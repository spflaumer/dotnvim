vim.loader.enable()

local utils = require"utils"

require"options"
require"keymap"
require"bootstrap"

require"lazy".setup("plugins", utils.config "lazy")

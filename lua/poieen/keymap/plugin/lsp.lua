local wk = require("which-key")
local tbuiltin = require("telescope.builtin")

wk.register({
        l = {
                name = "lsp",
                c = {
                        name = "calls",
                        o = { tbuiltin.lsp_outgoing_calls, "outgoing calls" },
                        i = { tbuiltin.lsp_incoming_calls, "incoming calls" },
                },
                t = { function() require("trouble").open("document_diagnostics") end, "open trouble" },
                T = { function() require("trouble").open("workspace_diagnostics") end, "open trouble" },
        }
}, { silent = true, noremap = true, remap = false, mode = "n", prefix = "<leader>" })

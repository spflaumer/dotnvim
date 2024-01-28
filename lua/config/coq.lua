return {
    auto_start = "shut-up",
    ["match.look_ahead"] = 4,
    ["completion.skip_after"] = { "{", "}", "[", "]" },
    display = {
        ["ghost_text.context"] = { "<-", "" },
        ["pum.source_context"] = { "from ", "" },
        ["preview.positions"] = { east = 1, north = 2, south = 3, west = 4 },
        ["preview.border"] = "rounded",
    },
    clients = {
        lsp = {
            weight_adjust = 1.4,
            resolve_timeout = 0.65,
        },
        ["buffers.weight_adjust"] = 1,
        ["tree_sitter.enabled"] = true,
    },
    limits = {
        completion_auto_timeout = 0.080,
        completion_manual_timeout = 0.6,
    }
}

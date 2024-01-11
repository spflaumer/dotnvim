local mason_reg = require "mason-registry"

local formatters = {}
local formatters_by_ft = {}

for _, pkg in pairs(mason_reg.get_installed_packages()) do
    for _, type in pairs(pkg.spec.categories) do
        -- only act upon a formatter
        if type == "Formatter" then
            -- if formatter doesn't have a builtin config create out own generic one
            if not require "conform".get_formatter_config(pkg.spec.name) then
                -- the key of the entry to this table
                -- is the name of the bare executable
                -- the actual value may not be the absolute path
                -- in some cases
                local bin = next(pkg.spec.bin)
                -- this should be replaced by a function
                -- that quieries the configured mason install path
                local prefix = vim.fn.stdpath("data") .. "/mason/bin/"

                formatters[pkg.spec.name] = {
                    command = prefix .. bin,
                    args = { "$FILENAME" },
                    stdin = true,
                    require_cwd = false
                }
            end

            -- finally add the formatter to it's compatible filetype(s)
            for _, ft in pairs(pkg.spec.languages) do
                local ftl = string.lower(ft)
                formatters_by_ft[ftl] = formatters_by_ft[ftl] or {}
                table.insert(formatters_by_ft[ftl], pkg.spec.name)
            end
        end
    end
end

return {
    format_on_save = { lsp_fallback = true, timeout_ms = 500 },
    formatters = formatters,
    formatters_by_ft = formatters_by_ft
}

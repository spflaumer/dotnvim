-- setup for servers that *I* didn't install with mason.nvim
-- disable this if you don't use these

return function(onattach, capabilities)
    require "lspconfig".clangd.setup(require "coq".lsp_ensure_capabilities {
        onattach = onattach,
        capabilities = capabilities,
    })
end

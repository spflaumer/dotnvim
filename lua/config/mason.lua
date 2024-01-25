return {
    ui = {
        border = "rounded",
        icons = {
            package_pending = "\u{f192}",
            package_installed = "\u{f111}",
            package_uninstalled = "\u{eabd}",
        },
        keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            check_server_version = "c",
            update_all_servers = "U",
            check_outdated_servers = "C",
            uninstall_server = "X",
            cancel_installation = "<C-c>",
        }
    },
    max_concurrent_installers = 4,
}

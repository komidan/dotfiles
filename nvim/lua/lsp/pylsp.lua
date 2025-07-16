vim.lsp.config["pylsp"] = {
    cmd = { "pylsp" },
    filetypes = { "python" },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    ignore = { "E501", "E305", "E302", "E261" }
                }
            }
        }
    }
}

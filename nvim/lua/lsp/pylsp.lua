vim.lsp.config["pylsp"] = {
    cmd = { "pylsp" },
    filetypes = { "python" },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    ignore = {
<<<<<<< HEAD
                        "E501", "E305", "E302", "E261", "E221", "E303",
                        "E265", "E301", "E241"
                    }
                }
=======
                        "E501", "E305", "E302", "E261",
                        "E221", "E303", "E265", "E251",
                    },
                    maxLineLength = 120,
                 } ,
               pyflakes = { enabled = true },
>>>>>>> 96d8258 (more changes)
            }
        }
    }
}

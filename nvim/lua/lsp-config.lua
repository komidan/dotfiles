
require("lsp.pylsp")
require("lsp.lua_ls")
require("lsp.rust")
require("lsp.clangd")

vim.lsp.enable({
    "pylsp",
    "lua_ls",
    "rust-analyzer",
    "clangd",
})

vim.diagnostic.config({
    virtual_text = { spacing = 0, prefix = "-" },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
})

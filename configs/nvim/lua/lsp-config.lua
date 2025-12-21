
-- Language Server Protocol
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
    virtual_text = {
        spacing = 0,
        prefix = "-"
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
})

vim.api.nvim_create_user_command("LspRestart", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
        if client.name == "clangd" then
            client:stop(false)  -- no force, let it shutdown cleanly
        end
    end
    -- small delay to allow shutdown
    vim.defer_fn(function()
        vim.cmd("edit")  -- reload buffer to reattach
    end, 100)  -- 100 ms delay
end, {})


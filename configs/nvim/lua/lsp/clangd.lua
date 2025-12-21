vim.lsp.config["clangd"] = {
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp" },
    root_markers = { ".git", "compile_commands.json", "compile_flags.txt" },
    init_options = {
        fallbackFlags = {
            "-std=c99",
            "-x", "c",
            "-I" .. vim.fn.getcwd() .. "/inc",
            "-I" .. vim.fn.getcwd() .. "/lib",
            "-Wall",
            "-Wextra",
        }
    },
}

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.h",
    callback = function()
    vim.bo.filetype = "c"
    end
})

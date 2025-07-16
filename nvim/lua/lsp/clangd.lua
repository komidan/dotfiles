vim.lsp.config["clangd"] = {
    cmd = { 'clangd', '--background-index' },
    root_markers = { 'compile_commands.json', 'compile_flags.txt' },
    filetypes = { 'c', 'cpp' },
    settings = {
        clangd = {
            init_options = {
                fallbackFlags = { '--std=c99' }
            },
            semanticHighlighting = false,
        }
    },
    vim.api.nvim_set_hl(0, '@lsp.type.comment.cpp', {}),
}

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = 'master',
    lazy = false,

    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {
                -- langs
                "c",
                "cpp",
                "python",
                "lua",

                -- vim
                "vim",
                "vimdoc",

                -- qol
                "query",
                "markdown",
                "markdown_inline",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
        })
    end
}

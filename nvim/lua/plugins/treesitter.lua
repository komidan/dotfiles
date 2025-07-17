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
                disable = { "c", "rust" },

                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = false,
            },
        })
    end
}

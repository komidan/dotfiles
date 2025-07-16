return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = ...,
    config = function()
        local config = require("gruvbox")
        config.setup({
            terminal_colors = true,
            bold = true,
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
                folds = false,
            },
            inverse = false,
            contrast = 'hard'
        })
        vim.cmd("colorscheme gruvbox")
    end
}


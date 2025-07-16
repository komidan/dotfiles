return {
    'numToStr/Comment.nvim',
    opts = {
        config = function()
            require('Comment').setup({
                padding = true,
                sticky = true,
            })
        end
    }
}

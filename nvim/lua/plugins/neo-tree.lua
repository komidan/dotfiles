return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
        local config = require('neo-tree')
        config.setup({
            event_handlers = {
                {
                    event = "file_open_requested",
                    handler = function()
                        -- auto close
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },
            },
            source_selector = {
                winbar = false,
                statusline = false,
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false,
                },
                group_empty_dirs = true
            }
        })
        vim.keymap.set('n', "<C-n>", ':Neotree toggle reveal float<CR>')
        vim.keymap.set('n', "<C-b>", ':Neotree reveal float buffers<CR>')
        vim.keymap.set('n', "<C-g>", ':Neotree toggle right git_status<CR>')
    end
}


return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
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
            window = {
                position = "right",
                width = 30,
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
        vim.keymap.set('n', "<C-n>", ':Neotree reveal<CR>')
    end
}


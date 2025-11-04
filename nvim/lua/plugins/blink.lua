return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },

        version = '1.*',

        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'super-tab' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            completion = {
                trigger = {
                    show_on_insert = false,
                    show_on_keyword = false,
                    show_on_trigger_character = false,

                    show_on_backspace = false,
                    show_on_backspace_in_keyword = false,
                    show_on_backspace_after_accept = true,
                    show_on_backspace_after_insert_enter = true,
                },

                -- menu = {
                --     auto_show = false,
                --     auto_show_delay_ms = 500,
                -- },

                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },

                ghost_text = {
                    enabled = false,
                },
            },
        },
        opts_extend = { "sources.default" },
    },

}

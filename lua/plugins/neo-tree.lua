return {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
                -- Disable auto-opening when entering a directory
                event_handlers = {
                        {
                                event = "vim_enter",
                                handler = function()
                                        -- Do nothing, prevents auto-open
                                end,
                        },
                },
        },
        -- Disable the default keybindings
        keys = {
                { "<leader>e", false },
                { "<leader>E", false },
        },
}

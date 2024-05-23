return {
    {
        "NvChad/nvim-colorizer.lua",
        config = function(_, opts)
            require("colorizer").setup()
        end
    },

    {
        'numToStr/Comment.nvim',
        config = function(_, opts)
            require('Comment').setup()
        end
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "TroubleToggle", "Trouble" },
        keys = {
            { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'Document Diagnostics (Trouble)'},
        },
        opts = {
            use_diagnostic_signs = true,
        },
 },
}

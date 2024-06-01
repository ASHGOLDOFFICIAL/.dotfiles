return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {'<C-n>', '<cmd>NvimTreeToggle<CR>', desc = "Toggle Nvim Tree" },
        },
        opts = function()
            return require("configs.nvim-tree")
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        branch = "0.1.x",

        cmd = 'Telescope',
        keys = {
            { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Find Files' },
            { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = 'Live grep' },
        },
        opts = {
            defaults = {
                layout_strategy = 'vertical',
                layout_config = {
                    vertical = {
                      prompt_position = 'top',
                    }
                },
            },
        },
    },

    "lambdalisue/suda.vim",
}


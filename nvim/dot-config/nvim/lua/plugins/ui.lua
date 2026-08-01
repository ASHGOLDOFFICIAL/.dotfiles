return {
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        opts = {
            config = {
                week_header = {
                    enable = true,
                },
            },
            hide = { statusline, tabline, winbar },
        },
        config = function(_, opts)
            require("dashboard").setup(opts)
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = function()
            return require("configs.lualine")
        end,
        config = function(_, opts)
            require("lualine").setup(opts)
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            exclude = { filetypes = { "dashboard" } },
        },
        config = function(_, opts)
            require("ibl").setup(opts)
        end,
    },

    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        keys = {
            { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" }
        },
        opts = {
            plugins = {
                gitsigns = true,
                tmux = true,
                alacritty = {
                    enabled = true,
                    font = "14",
                },
            },
        },
        dependencies = { "folke/twilight.nvim" },
    },
}

return {
    {
        "folke/tokyonight.nvim",
        enabled = true,
        lazy = false,
        priority = 1000,
        opts = {
            sidebars = {"qf", "help", "terminal"},
            style = "night",
            transparent = (not vim.g.neovide),
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
        end,
    },
}

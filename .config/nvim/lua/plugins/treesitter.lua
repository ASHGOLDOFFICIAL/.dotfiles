return {
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = not vim.g.nixos,
        opts = function()
            return require("configs.treesitter")
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}

return {
    {
        "williamboman/mason.nvim",
        enabled = not vim.g.nixos,
        cmd = 'Mason',
        opts = function()
            return require("configs.mason")
        end,
    }
}

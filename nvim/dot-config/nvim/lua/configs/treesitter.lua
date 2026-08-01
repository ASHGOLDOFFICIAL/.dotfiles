local options = {
    ensure_installed = {
        "cmake",
        "c",
        "cpp",
        "css",
        "gitcommit",
        "gitignore",
        "html",
        "http",
        "javascript",
        "lua",
        "nix",
        "query",
        "python",
        "scss",
        "sql",
        "vim",
        "vimdoc",
        "vue",
    },
    auto_install = not vim.g.nixos,

    indent = {
        enable = true,
    },

    highlight = {
        enable = true,
    },
}

return options

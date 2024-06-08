return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "williamboman/mason.nvim" },
                enabled = not vim.g.nixos,
                opts = function()
                    return require("configs.mason-lspconfig")
                end,
                config = function(_, opts)
                    require("mason").setup()
                    require("mason-lspconfig").setup(opts)
                end,
            },
        },
        opts = {
            servers = {
                cssls = {},
                clangd = {},
                html = {},
                jsonls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = "Disable",
                                semicolon = "Disable",
                                arrayIndex = "Disable",
                            },
                            format = {
                                enable = true,
                                default_config = {
                                    indent_style = "space",
                                },
                            },
                        },
                    },
                },
                nil_ls = {},
                pylsp = {},
                rust_analyzer = {},
                tsserver = {},
            },
            setup = {},
        },
        config = function(_, opts)
            local servers = opts.servers
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
              "force",
              {},
              vim.lsp.protocol.make_client_capabilities(),
              has_cmp and cmp_nvim_lsp.default_capabilities() or {},
              opts.capabilities or {}
            )

            local function setup(server)
              local server_opts = vim.tbl_deep_extend("force", {
                capabilities = vim.deepcopy(capabilities),
              }, servers[server] or {})

              if opts.setup[server] then
                if opts.setup[server](server, server_opts) then
                  return
                end
              elseif opts.setup["*"] then
                if opts.setup["*"](server, server_opts) then
                  return
                end
              end
              require("lspconfig")[server].setup(server_opts)
            end

            for server, server_opts in pairs(servers) do
              if server_opts then
                server_opts = server_opts == true and {} or server_opts
                setup(server)
              end
            end
        end,
    },

    {
        "williamboman/mason.nvim",
        enabled = not vim.g.nixos,
        cmd = 'Mason',
        opts = function()
            return require("configs.mason")
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "neovim/nvim-lspconfig",
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
            },
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
        },
        opts = function()
            return require("configs.cmp")
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },
}

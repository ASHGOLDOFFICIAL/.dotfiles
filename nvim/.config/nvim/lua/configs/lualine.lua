return {
    options = {
        icons_enabled = true,
        globalstatus = true,
        disabled_filetypes = {
            statusline = { "NvimTree", "dashboard" },
            winbar = { "NvimTree", "dashboard" },
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { { "filename", path = 1, } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "encoding", "fileformat", "filetype" },
        lualine_z = { "location" }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
    },
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
}


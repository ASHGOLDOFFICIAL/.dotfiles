local g = vim.g
local o = vim.opt
local key = vim.keymap

g.mapleader = " "
key.set({ "n", "i", "t", "v" }, "<C-]>", "<ESC>", { noremap = true })
key.set({ "n" }, "<M-BS>", "vbd")
key.set({ "i" }, "<M-BS>", "<ESC>vbc")

o.termguicolors = true
o.clipboard = "unnamedplus"


-- Mouse
o.mouse = "a"
o.mousemodel = "extend"


-- Lines and columns 
o.number = true
o.relativenumber = true
o.cursorline = true
o.colorcolumn = "80"
o.wrap = false


-- Indentation
o.autoindent = true
o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4


-- Windows
o.splitbelow = true
o.splitright = true


require("terminal")


-- Neovide
if g.neovide then
    o.linespace = 0
    g.neovide_fullscreen = false
    g.neovide_transparency = 0.9
end


-- Check for NixOS
local handle = io.popen("grep -Po '(?<=^NAME=).+' /etc/os-release")
if handle ~= nil then
    g.nixos = string.gsub(handle:read("*a"), "\n", "") == "NixOS"
end


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
o.rtp:prepend(lazypath)

-- Lazy plugin manager
local lazy = require("lazy")
local lazy_opts = require("configs.lazy")
lazy.setup("plugins", lazy_opts)


if g.nixos then
    --local opts = require("configs.treesitter")
    require("nvim-treesitter.configs").setup({ auto_install = false })
end


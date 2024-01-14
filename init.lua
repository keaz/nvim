vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=4")
vim.api.nvim_set_option('updatetime', 200)

local wo = vim.wo
wo.number = true
wo.relativenumber = true
wo.signcolumn = "yes"
wo.wrap = false
wo.cursorline = true


--require("basics")
--require("globals")
--require("keymappings")
require("plugins")
require("plugins.plugin-config.treesitter")
require("plugins.plugin-config.colorscheme")
require("plugins.plugin-config.mason")
require("plugins.plugin-config.nvim-lspconfig")
require("plugins.plugin-config.telescope")
require("plugins.plugin-config.rust-tools")
require("plugins.plugin-config.neo-tree")
require("plugins.plugin-config.completions")
require("plugins.plugin-config.lualine")
require("config.autocmds")

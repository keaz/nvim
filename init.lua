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
--require("plugins.plugin-config.rust-tools")
require("plugins.plugin-config.neo-tree")
require("plugins.plugin-config.completions")
require("plugins.plugin-config.lualine")
require("plugins.plugin-config.toggleterm")
require("plugins.plugin-config.dap")
require("plugins.plugin-config.bufferline")
require("config.autocmds")
require("config.keymaps")


local signs = {
    Error = " ", -- U+f659
    Warn = " ", -- U+f529
    Hint = " ", -- U+f835
    Info = " " -- U+f449
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

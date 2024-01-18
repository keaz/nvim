local builtin = require("telescope.builtin")
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fD', '<cmd>Telescope diagnostics<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Telescope lsp_definitions<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fi', '<cmd>Telescope lsp_implementations<cr>', { noremap = true, silent = true })

require("telescope").setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
        }
    }
}
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")


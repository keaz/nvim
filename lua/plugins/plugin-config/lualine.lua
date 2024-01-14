require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        -- Other options...
    },
    sections = {
        lualine_c = {
            'filename',
            {
                'lsp_progress',  -- Displays LSP progress
            }
        },
        -- Other sections
    }
}

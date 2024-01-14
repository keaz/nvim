require'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "vim", "rust", "ron", "toml", "java", "yaml", "bash" },
    highlight = { enable = true },
    indent = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}

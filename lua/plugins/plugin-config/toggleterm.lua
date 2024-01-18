require("toggleterm").setup{
    size = 20,  -- The terminal window size
    open_mapping = [[<c-\>]],  -- The key mapping to toggle the terminal
    hide_numbers = true,  -- Hide the line number in the terminal
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    persist_size = true,
    direction = 'float',  -- The terminal can be 'horizontal', 'vertical', or 'float'
    close_on_exit = true,  -- Close the terminal window when the process exits
    shell = vim.o.shell,  -- Use the default shell
}


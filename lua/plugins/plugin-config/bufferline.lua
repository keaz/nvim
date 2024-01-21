require('bufferline').setup {
    options = {
        numbers = "ordinal",             -- "none" | "ordinal" | "buffer_id" | "both"
        close_command = "bdelete! %d",   -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil,      -- can be a string | function, see "Mouse actions"
    }
}


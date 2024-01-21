local dap, dapui = require("dap"), require("dapui")


dapui.setup({
    icons = {
        expanded = "▾",
        collapsed = "▸"
    },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r"
    },
    sidebar = {
        open_on_start = true,
        elements = {
            -- You can change the order of elements in the sidebar
            "scopes",
            "breakpoints",
            "stacks",
            "watches"
        },
        width = 40,
        position = "left" -- Can be "left" or "right"
    },
    tray = {
        open_on_start = true,
        elements = { "repl" },
        height = 10,
        position = "bottom" -- Can be "bottom" or "top"
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil   -- Floats will be treated as percentage of your screen.
    }
})

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

vim.fn.sign_define('DapBreakpoint', { text = '🐛', texthl = '', linehl = '', numhl = '' })
vim.keymap.set("n", "<leader>dB", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<leader>dt", ":DapTerminate<CR>")
vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>")
vim.keymap.set("n", "<leader>di", ":DapStepInto<CR>")
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>")
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>")


local mason_registry = require("mason-registry")

local codelldb = mason_registry.get_package("codelldb")
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },

    }
}

dap.configurations.rust = {
    {
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        terminal = 'integrated',
        sourceLanguages = { 'rust' }
    }
}


dap.adapters.java = {
    type = 'executable',
    command = 'java',
    args = { '-jar', '/Users/kasunranasinghe/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar' }
}

dap.configurations.java = {
    {
        type = 'java',
        request = 'attach', -- or 'launch'
        name = "Debug (Attach) - Java",
        hostName = "127.0.0.1",
        port = 1044, -- Adjust the port
        -- For 'launch' request, you'll need additional launch-specific configurations
    },
}

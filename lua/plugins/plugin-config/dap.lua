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

vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
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
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        -- CHANGE THIS to your path!
        command = codelldb_path,
        args = { "--port", "${port}" },

        -- On windows you may have to uncomment this:
        -- detached = false,
    }
}
--dap.adapters.codelldb = {
--    type = 'server',
--    host = '127.0.0.1',
--    port = 13000 -- 💀 Use the port printed out or specified with `--port`
--}
--dap.configurations.c = {
--    {
--        type = 'codelldb',
--        request = 'launch',
--        program = function()
--            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--        end,
--        --program = '${fileDirname}/${fileBasenameNoExtension}',
--        cwd = '${workspaceFolder}',
--        terminal = 'integrated'
--    }
--}

dap.configurations.rust = {
    {
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        terminal = 'integrated',
        sourceLanguages = { 'rust' }
    }
}

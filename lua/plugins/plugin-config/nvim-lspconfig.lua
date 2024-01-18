local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

-- lua
lspconfig.lua_ls.setup({
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
    capabilities = capabilities,
})

-- rust-analyzer
require("rust-tools").setup({
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
        },
        on_initialized = function()
            vim.cmd([[
              augroup RustLSP
                autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
              augroup END
            ]])
        end,
    },
    server = {
        keys = {
            { "K",          "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
            { "<leader>cR", "<cmd>RustCodeAction<cr>",   desc = "Code Action (Rust)" },
            { "<leader>dr", "<cmd>RustDebuggables<cr>",  desc = "Run Debuggables (Rust)" },
        },
        on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                },
                checkOnSave = {
                    allFeatures = true,
                    command = "clippy",
                    extraArgs = { "--no-deps" },
                },
                procMacro = {
                    enable = true,
                    ignored = {
                        ["async-trait"] = { "async_trait" },
                        ["napi-derive"] = { "napi" },
                        ["async-recursion"] = { "async_recursion" },
                    },
                },
            },
        },
    },
})


-- Java jdtls
lspconfig.jdtls.setup({
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
        if client.name == "jdtls" then
        end
    end,
    capabilities = capabilities,
    settings = {
        ["java"] = {
            autobuild = {
                enabled = true,
            },
            saveActions = {
                organizeImports = true,
            },
            cleanup = {
                actionsOnSave = {
                    "qualifyStaticMembers",
                    "qualifyMembers",
                    "addDeprecated",
                    "stringConcatToTextBlock",
                    "instanceofPatternMatch",
                    "lambdaExpression",
                    "switchExpression",
                },
            },
            imports = {
                maven = {
                    enabled = true,
                    downloadSources = true,
                },
                gradle = {
                    enabled = true,
                },
            },
            maven = {
                downloadSources = true,
                updateSnapshots = true,
            },
            format = {
                enabled = true,
                comments = {
                    enable = true,
                },
                onType = {
                    enabled = true,
                },
                insertSpaces = true,
                tabSize = 4,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            signatureHelp = {
                enabled = true,
            },
            jdtl = {
                ls = {
                    lombokSupport = {
                        enabled = true,
                    }
                }
            },
            symbol = {
                includeSourceMethodDeclarations = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            contentProvider = {
                preferred = "fernflower",
            },
            codeGeneration = {
                generateComments = true,
            }

        },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

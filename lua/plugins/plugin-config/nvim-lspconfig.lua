local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
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
lspconfig.rust_analyzer.setup({
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
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
                buildScripts = {
                    enable = true,
                },
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
})

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

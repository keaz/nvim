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
        inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
        },
        autoSetHints = true,
        runnables = {
            use_telescope = true,
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
                assist = {
                    importGranularity = "module",
                    importPrefix = "by_self",
                },
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    autoreload = true,
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                    buildScripts = {
                        enable = true,
                    },
                },
                diagnostics = {
                    disabled = { "unresolved-proc-macro" },
                    enableExperimental = true,
                    enable = true,
                    warnings = true,
                    macroWarnings = true,
                    unstableFeatures = true,
                    enableFor = { "clippy" },
                },
                completion = {
                    addCallArgumentSnippets = true,
                    addCallParenthesis = true,
                    postfix = {
                        enable = true,
                    },
                },
                checkOnSave = {
                    allFeatures = true,
                    command = "clippy",
                    extraArgs = { "--no-deps" },
                },
                inlayHints = {
                    chainingHints = true,
                    parameterHints = true,
                    typeHints = true,
                    enabled = true,
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


local jdtls = require("jdtls")
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true



local home = os.getenv "HOME"
local workspace_path = home .. "/.local/share/lunarvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local os_config = "linux"
if vim.fn.has "mac" == 1 then
    os_config = "mac"
end

local bundles = {}

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(
            "/Users/kasunranasinghe/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
        "\n"
    )
)
-- Java jdtls
lspconfig.jdtls.setup({
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
        "-jar",
        vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_config,
        "-data",
        workspace_dir,
    },
    init_options = {
        bundles = bundles,
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
        if client.name == "jdtls" then
            require("jdtls").setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
            vim.lsp.codelens.refresh()
        end
    end,
    capabilities = capabilities,
    settings = {
        ["java"] = {
            configuration = {
                updateBuildConfiguration = "interactive",
            },
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
            eclipse = {
                downloadSources = true,
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
            },
            extendedClientCapabilities = extendedClientCapabilities,

        },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

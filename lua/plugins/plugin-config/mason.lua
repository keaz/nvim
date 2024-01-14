require("mason").setup({
  ui = {
    icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
    }
  },
  ensure_installed = { "jdtls"},
})
-- require("mason-lspconfig").setup({
--   ensure_installed = { "lua_ls", "rust_analyzer","taplo"},
--   automatic_installation = true,
-- })
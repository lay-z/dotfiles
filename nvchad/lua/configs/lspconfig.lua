require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyzer" }
vim.lsp.enable(servers)

vim.lsp.set_log_level "warn"

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = {
        allTargets = true,
      },
      -- Makes sure that rust-analyzer checks buidls all features on project
      cargo = {
        features = "all",
      },
    },
  },
})

-- read :h vim.lsp.config for changing options of lsp servers

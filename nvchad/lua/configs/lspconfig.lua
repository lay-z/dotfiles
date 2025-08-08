local nvchad_config = require "nvchad.configs.lspconfig"
-- local dotfiles = require("nvchad.utils.dotfiles")

local map = vim.keymap.set

-- Try to overwrite the default on_attach function
nvchad_config.on_attach = function(_, bufnr)
  map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references", buffer = bufnr }) -- show definition, references

  map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr }) -- go to declaration

  map("n", "gtd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions", buffer = bufnr }) -- show lsp definitions

  map("n", "gti", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations", buffer = bufnr }) -- show lsp implementations

  map("n", "gtt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions", buffer = bufnr }) -- show lsp type definitions

  map({ "n", "v" }, "<leader>lca", vim.lsp.buf.code_action, { desc = "See available code actions", buffer = bufnr }) -- see available code actions, in visual mode will apply to selection

  map("n", "<leader>lrn", vim.lsp.buf.rename, { desc = "Smart rename (incremental edition)", buffer = bufnr }) -- smart rename

  map("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics", buffer = bufnr }) -- show  diagnostics for file

  map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show line diagnostics", buffer = bufnr }) -- show diagnostics for line

  map("n", "[d", function() vim.diagnostic.jump({count = -1, float = true }) end, { desc = "Go to previous diagnostic", buffer = bufnr }) -- jump to previous diagnostic in buffer

  map("n", "]d", function() vim.diagnostic.jump({count = 1, float = true }) end, { desc = "Go to next diagnostic", buffer = bufnr }) -- jump to next diagnostic in buffer

  map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor", buffer = bufnr }) -- show documentation for what is under cursor

  map("n", "<leader>fm", function()
    vim.lsp.buf.format { async = true }
  end, { desc = "Format the file", buffer = bufnr })

  map("n", "<leader>lfu", function()
    vim.cmd.Telescope("lsp_document_symbols", { symbols = "function" })
  end, { desc = "List functions from lsp for current file in telescope window", buffer = bufnr })

  map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = bufnr })
  map("n", "<leader>ra", require "nvchad.lsp.renamer", { desc = "NvRenamer", buffer = bufnr })
end

nvchad_config.defaults()

local servers = {
  html = {},
  cssls = {},
  rust_analyzer = {
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
  },
  bashls = {},
  lua_ls = {},
  ts_ls = {},
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name) -- nvim v0.11.0 or above required
  vim.lsp.config(name, opts) -- nvim v0.11.0 or above required
end
-- vim.lsp.enable(servers)
--
-- vim.lsp.set_log_level "warn"
--
-- vim.lsp.config("rust_analyzer", )

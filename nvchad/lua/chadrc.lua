-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "material-lighter",
  theme_toggle = { "material-lighter", "everforest_light" },
  transparency = false
}

M.ui = {
  telescope = {
    style = "bordered",
  },
  statusline = {
    enabled = true,
    theme = "vscode_colored",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "session_info", "lsp", "cursor", "cwd" },
    -- order = {
    --   "mode", "file", "git", ,
    -- },
    modules = {
      session_info = function()
        return require("nvim-possession").status()
      end,
    },
  },
}

-- M.nvdash = { load_on_startup = true }

return M

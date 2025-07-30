-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

local stl_utils = require("configs.stl")

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  transparency = false
}

local terminal_mode_path = "/home/layz/.local/state/TERMINAL_MODE"
local terminal_mode = nil

local file = io.open(terminal_mode_path, "r")
vim.notify("Terminal mode file found: " .. tostring(file ~= nil), vim.log.levels.DEBUG)
if file then
  terminal_mode = file:read("*l")
  file:close()
end

vim.notify("Terminal mode: " .. terminal_mode, vim.log.levels.DEBUG)
if terminal_mode == "light" then
  vim.notify("Using light terminal mode", vim.log.levels.DEBUG)
  M.base46.theme = "ayu_light"
end

M.ui = {
  telescope = {
    style = "bordered",
  },
  statusline = {
    enabled = true,
    theme = "vscode_colored",
    order = { "mode", "full_file_path", "git", "%=", "lsp_msg", "%=", "diagnostics", "session_info", "lsp", "cursor", "cwd" },
    -- order = {
    --   "mode", "file", "git", ,
    -- },
    modules = {
      session_info = function()
        return require("nvim-possession").status()
      end,
      -- Method pretty much copied from https://github.com/NvChad/ui/blob/v3.0/lua/nvchad/stl/utils.lua#L83
      full_file_path = function()
        -- return "test"
        return stl_utils.files()
      end
    },
  },
}

-- M.nvdash = { load_on_startup = true }

return M

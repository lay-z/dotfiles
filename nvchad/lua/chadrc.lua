-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  transparency = false
}

local terminal_mode_path = "/home/layz/.local/state/TERMINAL_MODE"
local terminal_mode = nil

local file = io.open(terminal_mode_path, "r")
print("Terminal mode file found: " .. tostring(file ~= nil))
if file then
  terminal_mode = file:read("*l")
  file:close()
end

print("Terminal mode: " .. terminal_mode)
if terminal_mode == "light" then
  M.base46.theme = "ayu_light"
end

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

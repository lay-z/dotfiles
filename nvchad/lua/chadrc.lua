-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded-arc",
  theme_toggle = { "bearded-arc", "one_light" },
}

M.ui = {
  telescope = {
    style = "bordered",
  },
}

-- M.nvdash = { load_on_startup = true }

return M

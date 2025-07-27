local M = {}

local utils = require "nvchad.stl.utils"

-- TODO unclear how maintainable this will be
-- Got this function from M.files - https://github.com/NvChad/ui/blob/v3.0/lua/nvchad/stl/utils.lua#L83
M.get_file_path = function()
  -- credits to ii14 for str:match func
  local icon = "󰈚"
  local path = vim.api.nvim_buf_get_name(utils.stbufnr())
  local name = (path == "" and "Empty") or path:match "([^/\\]+)[/\\]*$"

  if name ~= "Empty" then
    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

    if devicons_present then
      local ft_icon = devicons.get_icon(name)
      icon = (ft_icon ~= nil and ft_icon) or icon
    end
  end

  return { icon, path }
end

-- https://github.com/NvChad/ui/blob/v3.0/lua/nvchad/stl/vscode.lua#L16C1-L20C4
M.files = function()
  local x = M.get_file_path()
  local name = " " .. x[2] .. " "
  return "%#StText# " .. x[1] .. name
end



return M

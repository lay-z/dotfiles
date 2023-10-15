local colourscheme = "nightfly"
local status, _ = pcall(vim.cmd, "colorscheme " .. colourscheme)
if not status then
  print("colourscheme " .. colourscheme .. " not found. Install it!!")
  return
end

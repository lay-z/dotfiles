local defaults = {
	background = "dark",
	colorscheme = "catppuccin",
}

local terminal_mode_path = "/home/layz/.local/state/TERMINAL_MODE"
local terminal_mode = nil

local file = io.open(terminal_mode_path, "r")

-- TODO understand why is this printing out when the log level has been set to DEBUG!
-- vim.notify("Terminal mode file found: " .. tostring(file ~= nil), vim.log.levels.DEBUG)
if file then
	terminal_mode = file:read("*l")
	file:close()
end

vim.notify("Terminal mode: " .. terminal_mode, vim.log.levels.DEBUG)
if terminal_mode == "light" then
	-- vim.notify("Using light terminal mode", vim.log.levels.DEBUG)
	defaults.background = "light"
end

return defaults

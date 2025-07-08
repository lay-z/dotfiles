-- Health check for custom plugins
local M = {}

function M.check_copilot_blink_integration()
  local health = vim.health or require "vim.health"

  health.start "Copilot + blink.cmp integration"

  -- Check if blink-copilot is loaded
  local blink_copilot_ok, blink_copilot = pcall(require, "blink-copilot")
  if blink_copilot_ok then
    health.ok "blink-copilot plugin is loaded"
  else
    health.error "blink-copilot plugin is not loaded"
  end

  -- Check if blink.cmp is loaded
  local blink_cmp_ok, blink_cmp = pcall(require, "blink.cmp")
  if blink_cmp_ok then
    health.ok "blink.cmp plugin is loaded"
  else
    health.error "blink.cmp plugin is not loaded"
  end

  -- Check if CopilotChat is loaded
  local copilot_chat_ok, copilot_chat = pcall(require, "CopilotChat")
  if copilot_chat_ok then
    health.ok "CopilotChat plugin is loaded"
  else
    health.error "CopilotChat plugin is not loaded"
  end

  -- Check if copilot source is configured in blink.cmp
  if blink_cmp_ok then
    local config = blink_cmp.config or {}
    local sources = config.sources or {}
    local providers = sources.providers or {}

    if providers.copilot then
      health.ok "Copilot source is configured in blink.cmp"
    else
      health.warn "Copilot source is not configured in blink.cmp"
    end
  end
end

return M


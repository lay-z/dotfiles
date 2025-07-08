-- Test script to verify blink-copilot integration
print("Testing blink-copilot integration...")

-- Test if blink-copilot is available
local blink_copilot_ok, blink_copilot = pcall(require, "blink-copilot")
if blink_copilot_ok then
  print("✓ blink-copilot plugin is available")
else
  print("✗ blink-copilot plugin is not available: " .. tostring(blink_copilot))
end

-- Test if blink.cmp is available
local blink_cmp_ok, blink_cmp = pcall(require, "blink.cmp")
if blink_cmp_ok then
  print("✓ blink.cmp plugin is available")
else
  print("✗ blink.cmp plugin is not available: " .. tostring(blink_cmp))
end

-- Test if CopilotChat is available
local copilot_chat_ok, copilot_chat = pcall(require, "CopilotChat")
if copilot_chat_ok then
  print("✓ CopilotChat plugin is available")
else
  print("✗ CopilotChat plugin is not available: " .. tostring(copilot_chat))
end

print("Integration test completed!")
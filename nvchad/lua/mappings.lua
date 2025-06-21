require "nvchad.mappings"


-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Telescope mappings
map("n", "<Space>fk", ":Telescope keymaps<CR>", { desc = "telescope find all keymaps" })

-- Custom writing keymaps
map("n", "<Space>wa", ":wa<CR>", { desc = "Write all buffers" })
map("n", "<Space>qa", ":qa!<CR>", { desc = "Exit all" })

-- Map ctrl-b to toggle horizontal terminal
map({ "n", "t", "i" }, "<Ctrl-b>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

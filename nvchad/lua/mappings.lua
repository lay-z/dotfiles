require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Telescope mappings
map("n", "<Leader>fk", ":Telescope keymaps<CR>", { desc = "telescope find all keymaps" })

-- Custom writing keymaps
map("n", "<Leader>wa", ":wa<CR>", { desc = "Write all buffers" })
map("n", "<Leader>wq", ":wqa<CR>", { desc = "Exit all" })
map("n", "<Leader>qa", ":qa!<CR>", { desc = "Exit all" })

-- Unmap LSP's <Leader>wa mapping to prevent conflict
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.schedule(function()
      pcall(function()
        vim.keymap.del("n", "<Leader>wa", { buffer = true })
      end)
      vim.keymap.set("n", "<Leader>wa", ":wa<CR>", { desc = "Write all buffers", buffer = true })
    end)
  end,
})

-- Stuff for the tabs
map("n", "<Leader>tc", ":tabnew<CR>", { desc = "Create new tab" })
map("n", "<Leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })
map("n", "<Leader>tn", ":tabn<CR>", { desc = "Go to next tab" })

-- Map ctrl-b to toggle horizontal terminal
-- map({ "n", "t", "i" }, "<C-b>", function()
--   require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
-- end, { desc = "terminal toggleable horizontal term" })

-- To make sure that plugin tmux-navigator does not conflict with the default
local nomap = vim.keymap.del
nomap({ "n" }, "<C-h>")
nomap({ "n" }, "<C-l>")
nomap({ "n" }, "<C-j>")
nomap({ "n" }, "<C-k>")

-- Remove leader-h and leader-v keymaps for nvchad term toggling
nomap({ "n" }, "<Leader>h")
nomap({ "n" }, "<Leader>v")

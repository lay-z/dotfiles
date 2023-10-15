vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>h", ":nohl<CR>") -- remove search highlighting

keymap.set("n", "x", '"_x') --character delete will not move to register

keymap.set("n", "<leader>+", "<C-a>") -- increment number under cursor
keymap.set("n", "<leader>-", "<C-x>") -- decrement number under cursor

keymap.set("n", "<leader>sv", "<C-w>v") --split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") --split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") --make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") --make split windows equal width

keymap.set("n", "<leader>w", ":wall<CR>") -- write all open buffers

keymap.set("n", "<leader>to", ":tabnew<CR>") 
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabnext<CR>") 
keymap.set("n", "<leader>tp", ":tabprevious<CR>")

keymap.set("n", "<leader>bp", ":bp<CR>")  -- Previous buffer
keymap.set("n", "<leader>bn", ":bn<CR>") -- Next buffer
keymap.set("n", "<leader>bx", ":bd<CR>") -- Close buffer TODO figure out how to close buffer, but bring on another buffer in window :thinking_face:
keymap.set("n", "<leader>tp", ":tabprevious<CR>")





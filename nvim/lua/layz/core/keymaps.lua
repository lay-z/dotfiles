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
keymap.set("n", "<leader>wq", ":wqall<CR>") -- write all open buffers
keymap.set("n", "<leader>q", ":q<CR>") -- write all open buffers

keymap.set("n", "<leader>to", ":tabnew<CR>:Telescope find_files hidden=true<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabnext<CR>")
keymap.set("n", "<leader>tp", ":tabprevious<CR>")

keymap.set("n", "<leader>bp", ":bp<CR>") -- Previous buffer
keymap.set("n", "<leader>bn", ":bn<CR>") -- Next buffer
keymap.set("n", "<leader>bx", ":bd<CR>") -- Close buffer TODO figure out how to close buffer, but bring on another buffer in window :thinking_face:

-- Getting commenting to work
keymap.set("n", "<C-t>", "gcc")
keymap.set("v", "<C-t>", "gc")

-- TODO think about some new keymaps
-- way to search and replace based on the word under current character.
-- Would have to do things for search and replace for line, vs for file
-- Ideally could also include search and replace selection

-- TODO should this be wrapped in a pcall? probably
-- TODO maybe this should be placed with the plugin.

local function get_command_history()
	local history = {}
	for i = vim.fn.histnr("cmd"), 1, -1 do
		local cmd = vim.fn.histget("cmd", i)
		if cmd ~= "" then
			table.insert(history, cmd)
		end
	end
	return history
end

function run_command_from_history()
	local history = get_command_history()
	vim.ui.select(history, {
		prompt = "Select a command to run:",
		format_item = function(item)
			return item
		end,
	}, function(item)
		if item then
			vim.cmd(item)
		end
	end)
end

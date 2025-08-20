return {
	"gennaro-tedesco/nvim-possession",
	dependencies = {
		"ibhagwan/fzf-lua",
		"nvim-tree/nvim-tree.lua",
	},
	config = true,
	opts = {
		autoload = true, -- Automatiacally load sessions defined for the current working directory
		autoswitch = {
			enable = true, -- Automatically saves and removes deletes any unsaved buffers currently open
		},
		autosave = {
			enable = true, -- Automatically saves the session when you quit the editor
		},
		-- post_hook = function()
		-- 	-- require("FTerm").open()
		-- 	print("post_hook posession!")
		-- 	-- require("nvim-tree").toggle(false, true)
		-- end,
	},
	init = function()
		-- should check if session location is created and create if not?
		local possession = require("nvim-possession")
		vim.keymap.set("n", "<leader>sl", function()
			possession.list()
		end)
		vim.keymap.set("n", "<leader>sn", function()
			possession.new()
		end)
		vim.keymap.set("n", "<leader>su", function()
			possession.update()
		end)
		vim.keymap.set("n", "<leader>sd", function()
			possession.delete()
		end)
	end,
}

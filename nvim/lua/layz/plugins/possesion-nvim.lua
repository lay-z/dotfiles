return {
	"gennaro-tedesco/nvim-possession",
	dependencies = {
		"ibhagwan/fzf-lua",
	},
	conig = true,
	opts = {
		autoload = true, -- Automatiacally load sessions defined for the current working directory
		autoswitch = {
			enable = true, -- Automatically saves and removes deletes any unsaved buffers currently open
		},
	},
	init = function()
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

return {
	"gennaro-tedesco/nvim-possession",
	dependencies = {
		"ibhagwan/fzf-lua",
		"nvim-tree/nvim-tree.lua",
	},
	config = true,
	keys = {
		{ "<leader>pl", function() require("nvim-possession").list() end, desc = "List sessions" },
		{ "<leader>pn", function() require("nvim-possession").new() end, desc = "New session" },
		{ "<leader>pu", function() require("nvim-possession").update() end, desc = "Update session" },
		{ "<leader>pd", function() require("nvim-possession").delete() end, desc = "Delete session" },
	},
	opts = {
		autoload = true,
		autoswitch = {
			enable = true,
		},
		autosave = {
			enable = true,
		},
	},
}

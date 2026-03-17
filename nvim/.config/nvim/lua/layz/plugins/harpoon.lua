return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>hm", function() require("harpoon.mark").add_file() end, desc = "Adds the current file to harpoon" },
		{ "<leader>ht", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Open harpoon quick menu UI" },
		{ "<leader>h1", function() require("harpoon.ui").nav_file(1) end, desc = "Navigate to 1st harpooned file" },
		{ "<leader>h2", function() require("harpoon.ui").nav_file(2) end, desc = "Navigate to 2nd harpooned file" },
		{ "<leader>h3", function() require("harpoon.ui").nav_file(3) end, desc = "Navigate to 3rd harpooned file" },
		{ "<leader>h4", function() require("harpoon.ui").nav_file(4) end, desc = "Navigate to 4th harpooned file" },
		{ "<leader>hp", function() require("harpoon.ui").nav_prev() end, desc = "Navigate to previous harpooned file" },
		{ "<leader>hn", function() require("harpoon.ui").nav_next() end, desc = "Navigate to next harpooned file" },
	},
	config = function()
		require("telescope").load_extension("harpoon")
	end,
}

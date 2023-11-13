return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local telescope = require("telescope")
		-- local harpoon = require("harpoon")
		local ui = require("harpoon.ui")
		local mark = require("harpoon.mark")
		telescope.load_extension("harpoon")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		local go_to = function(file_number)
			return function()
				ui.nav_file(file_number)
			end
		end

		keymap.set("n", "<leader>hm", mark.add_file, { desc = "Adds the current file to harpoon" })
		keymap.set("n", "<leader>ht", ui.toggle_quick_menu, { desc = "Open harpoon quick menu UI" })
		keymap.set("n", "<leader>1", go_to(1), { desc = "Navigate to 1st harpooned file" })
		keymap.set("n", "<leader>2", go_to(2), { desc = "Navigate to 2st harpooned file" })
		keymap.set("n", "<leader>3", go_to(3), { desc = "Navigate to 3st harpooned file" })
		keymap.set("n", "<leader>4", go_to(4), { desc = "Navigate to 4th harpooned file" })
		keymap.set("n", "<leader>hp", ui.nav_prev, { desc = "Navigate to previous harpooned file" })
		keymap.set("n", "<leader>hn", ui.nav_next, { desc = "Navigate to next harpooned file" })
	end,
}

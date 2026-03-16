return {
	"tpope/vim-fugitive",
	dependencies = { "tpope/vim-rhubarb" },
	keys = {
		{ "<leader>gl", "<cmd>.GBrowse!<CR>", mode = "n", desc = "Copy GitHub link for current line" },
		{ "<leader>gl", ":'<,'>GBrowse!<CR>", mode = "v", desc = "Copy GitHub link for selected lines" },
		{ "<leader>gL", "<cmd>.GBrowse<CR>", mode = "n", desc = "Open GitHub link for current line" },
		{ "<leader>gL", ":'<,'>GBrowse<CR>", mode = "v", desc = "Open GitHub link for selected lines" },
	},
}

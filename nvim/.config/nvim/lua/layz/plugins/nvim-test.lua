return {
	"vim-test/vim-test",
	dependencies = { "akinsho/toggleterm.nvim" },
	cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
	keys = {
		{ "<leader>tt", "<cmd>TestNearest<CR>", desc = "Test nearest" },
		{ "<leader>tT", "<cmd>TestFile<CR>", desc = "Test file" },
		{ "<leader>ta", "<cmd>TestSuite<CR>", desc = "Test suite" },
		{ "<leader>tl", "<cmd>TestLast<CR>", desc = "Test last" },
		{ "<leader>tg", "<cmd>TestVisit<CR>", desc = "Test visit" },
	},
	config = function()
		vim.cmd("let test#strategy = 'toggleterm'")
		vim.cmd("let test#neovim_sticky#reopen_window = 1")
	end,
}

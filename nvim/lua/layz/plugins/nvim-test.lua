return {
	"vim-test/vim-test",
	dependencies = { "akinsho/toggleterm.nvim" },
	vim.keymap.set("n", "<leader>tt", "<cmd>:TestNearest<CR>"),
	vim.keymap.set("n", "<leader>tT", "<cmd>:TestFile<CR>"),
	vim.keymap.set("n", "<leader>ta", "<cmd>:TestSuite<CR>"),
	vim.keymap.set("n", "<leader>tl", "<cmd>:TestLast<CR>"),
	vim.keymap.set("n", "<leader>tg", "<cmd>:TestVisit<CR>"),
	vim.cmd("let test#strategy = 'neovim_sticky'"), -- Use nvim terminal, but keep the same one open
	vim.cmd("let test#neovim_sticky#reopen_window = 1"), -- Reopen terminal split if not visible
	-- vim.cmd("let test#project_root = function('get_base_dir'"),
}

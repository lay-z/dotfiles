return {
	"alexghergh/nvim-tmux-navigation",
	opts = true,
	config = function()
		vim.keymap.set("t", "<C-h>", [[<C-\><C-n><Cmd>NvimTmuxNavigateLeft<CR>]], { desc = "Navigate left" })
		vim.keymap.set("t", "<C-j>", [[<C-\><C-n><Cmd>NvimTmuxNavigateDown<CR>]], { desc = "Navigate down" })
		vim.keymap.set("t", "<C-k>", [[<C-\><C-n><Cmd>NvimTmuxNavigateUp<CR>]], { desc = "Navigate up" })
		vim.keymap.set("t", "<C-l>", [[<C-\><C-n><Cmd>NvimTmuxNavigateRight<CR>]], { desc = "Navigate right" })
		vim.keymap.set("n", "<C-h>", [[<Cmd>NvimTmuxNavigateLeft<CR>]], { desc = "Navigate left" })
		vim.keymap.set("n", "<C-j>", [[<Cmd>NvimTmuxNavigateDown<CR>]], { desc = "Navigate down" })
		vim.keymap.set("n", "<C-k>", [[<Cmd>NvimTmuxNavigateUp<CR>]], { desc = "Navigate up" })
		vim.keymap.set("n", "<C-l>", [[<Cmd>NvimTmuxNavigateRight<CR>]], { desc = "Navigate right" })
		require("nvim-tmux-navigation").setup({})
	end,
}

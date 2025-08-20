return {
	"rcarriga/nvim-dap-ui",
	config = function()
		require("dapui").setup()

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>dt", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle dap ui" }) -- toggle ui for debugging
		keymap.set("n", "<leader>do", "<cmd>lua require('dapui').open()<CR>", { desc = "open dap ui" }) -- open ui for debugging
		keymap.set("n", "<leader>dc", "<cmd>lua require('dapui').close()<CR>", { desc = "close dap ui" }) -- close ui for debugging
	end,
}

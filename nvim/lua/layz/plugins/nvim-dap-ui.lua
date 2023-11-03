return {
	"rcarriga/nvim-dap-ui",
	config = function()
		require("dapui").setup()

		print("THIS IS WORKING in NVIM DAP UI")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>dt", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle dap ui" }) -- toggle file explorer
		keymap.set("n", "<leader>do", "<cmd>lua require('dapui').open()<CR>", { desc = "open dap ui" }) -- toggle file explorer
		keymap.set("n", "<leader>dc", "<cmd>lua require('dapui').close()<CR>", { desc = "close dap ui" }) -- toggle file explorer
		keymap.set("n", "<leader>de", "<cmd>lua print('test')<CR>", { desc = "close dap ui" }) -- toggle file explorer
	end,
}

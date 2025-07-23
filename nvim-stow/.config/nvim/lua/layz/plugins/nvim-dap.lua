return {
	"mfussenegger/nvim-dap",
	config = function()
		local keymap = vim.keymap
		keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
		keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.continue()<CR>")
		keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>")
		keymap.set("n", "<leader>dn", "<cmd>lua require'dap'.step_over()<CR>")
		keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>")
		keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.clear_breakpoints()<CR>")
	end,
}

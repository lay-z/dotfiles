return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	keys = {
		{ "<leader>dt", function() require("dapui").toggle() end, desc = "Toggle dap ui" },
		{ "<leader>do", function() require("dapui").open() end, desc = "Open dap ui" },
		{ "<leader>dC", function() require("dapui").close() end, desc = "Close dap ui" },
	},
	config = function()
		require("dapui").setup()
	end,
}

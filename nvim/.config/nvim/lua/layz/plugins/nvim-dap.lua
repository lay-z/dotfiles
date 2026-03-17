return {
	"mfussenegger/nvim-dap",
	keys = {
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
		{ "<leader>ds", function() require("dap").continue() end, desc = "DAP continue" },
		{ "<leader>dc", function() require("dap").continue() end, desc = "DAP continue" },
		{ "<leader>dn", function() require("dap").step_over() end, desc = "DAP step over" },
		{ "<leader>di", function() require("dap").step_into() end, desc = "DAP step into" },
		{ "<leader>dx", function() require("dap").clear_breakpoints() end, desc = "DAP clear breakpoints" },
	},
}

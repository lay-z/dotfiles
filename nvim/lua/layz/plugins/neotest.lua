return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"zidhuss/neotest-minitest", -- For ruby minitest support
		"nvim-neotest/nvim-nio",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-minitest")({
					test_cmd = function()
						return vim.tbl_flatten({
							-- "bundle",
							-- "exec",
							"./bin/rails",
							"test",
						})
					end,
				}),
				require("rustaceanvim.neotest"),
			},
		})
	end,
}

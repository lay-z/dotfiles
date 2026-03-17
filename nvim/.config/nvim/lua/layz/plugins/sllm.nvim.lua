return {
	"mozanunal/sllm.nvim",
	dependencies = {
		"echasnovski/mini.notify",
		"echasnovski/mini.pick",
	},
	cmd = "Sllm",
	keys = {
		{ "<leader>sa", "<cmd>Sllm ask<cr>", mode = { "n", "v" }, desc = "Ask LLM" },
	},
	opts = {
		default_model = "default",
	},
}

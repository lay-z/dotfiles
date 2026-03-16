return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		-- Recommended for `ask()` and `select()`.
		-- Required for `snacks` provider.
		---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	},
	keys = {
		{ "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" }, desc = "Ask opencode" },
		{ "<leader>os", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Execute opencode action…" },
		{ "<leader>ot", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "Toggle opencode" },
		{ "<leader>of", function() require("opencode").ask("@buffer: ", { submit = true }) end, mode = { "n", "x" }, desc = "place current buffer into opencode context" },
		{ "<leader>oo", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, expr = true, desc = "Add range to opencode" },
		{ "<leader>ooo", function() return require("opencode").operator("@this ") .. "_" end, expr = true, desc = "Add line to opencode" },
		{ "<leader>od", function() return require("opencode").operator("@diagnostics ") .. "_" end, expr = true, desc = "Add current buffer diagnostics to opencode" },
	},
	config = function()
		---@module "opencode"
		---@type opencode.Opts
		vim.g.opencode_opts = {}
		vim.o.autoread = true
	end,
}

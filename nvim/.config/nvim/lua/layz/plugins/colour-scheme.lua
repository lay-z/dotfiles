return {
	{
		"bluz71/vim-nightfly-colors",
		name = "nightfly",
		priority = 1000,
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "Shatur/neovim-ayu" },
	{ "rebelot/kanagawa.nvim" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{
		"baliestri/aura-theme",
		lazy = false,
		priority = 1000,
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
			-- vim.cmd([[colorscheme aura-dark]])
		end,
	},
	{ "vague2k/vague.nvim" },
	{ "maxmx03/dracula.nvim" },
}

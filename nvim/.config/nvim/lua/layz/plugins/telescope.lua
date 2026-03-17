return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Fuzzy find files in cwd" },
		{ "<leader>fhd", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Fuzzy find hidden files in cwd" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Fuzzy find recent files" },
		{ "<leader>fs", "<cmd>Telescope live_grep hidden=false<cr>", desc = "Find string in cwd" },
		{ "<leader>fy", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Find LSP workspace symbols" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Search through commands" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find active buffers" },
		{ "<leader>fht", "<cmd>Telescope help_tags<cr>", desc = "Find help tags" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Search through keymaps" },
		{ "<leader>fhi", "<cmd>Telescope command_history<cr>", desc = "Search through command history" },
		{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Search through jump list" },
		{ "<leader>fch", "<cmd>Telescope commands_history<cr>", desc = "Search through commands history" },
		{ "<leader>fo", "<cmd>Telescope commands<cr>Overseer", desc = "Search through all Overseer commands" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<C-d>"] = actions.delete_buffer,
					},
				},
			},
			pickers = {
				live_grep = {
					additional_args = function(_ts)
						return { "--hidden" }
					end,
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}

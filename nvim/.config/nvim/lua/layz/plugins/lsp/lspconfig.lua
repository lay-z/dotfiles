return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"mrcjkb/rustaceanvim",
		"b0o/schemastore.nvim",
		-- "simrat39/rust-tools.nvim",
	},
	opts = {
		inlay_hints = { enabled = true },
	},
	config = function()
		-- configure neovim lsp
		require("lazydev").setup()
		-- require("neodev").setup()

		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local on_attach = function(client, bufnr)
			local opts = {
				noremap = true,
				silent = true,
			}

			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to definition"
			keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gtd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gti", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gtt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename (incremental edition)"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- show diagnostics for line

			keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, { desc = "Go to previous diagnostic", buffer = bufnr }) -- jump to previous diagnostic in buffer

			keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, { desc = "Go to next diagnostic", buffer = bufnr }) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Format the file"
			vim.keymap.set("n", "<leader>lff", function()
				vim.lsp.buf.format({ async = true })
			end, opts)

			opts.desc = "List functions from lsp for current file in telescope window"
			vim.keymap.set("n", "<leader>lfu", function()
				vim.cmd.Telescope("lsp_document_symbols", { symbols = "function" })
			end, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- vim.lsp.client.on_attach = on_attach

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})
		local servers = {
			html = {},
			cssls = {},
			-- rust_analyzer = {
			-- 	settings = {
			-- 		["rust-analyzer"] = {
			-- 			check = {
			-- 				allTargets = true,
			-- 			},
			-- 			-- Makes sure that rust-analyzer checks buidls all features on project
			-- 			cargo = {
			-- 				features = "all",
			-- 			},
			-- 		},
			-- 	},
			-- },
			bashls = {},
			-- lua_ls = {},
			ts_ls = {},
		}

		for name, opts in pairs(servers) do
			vim.lsp.enable(name) -- nvim v0.11.0 or above required
			-- Add the same on attach for all. TODO figure out how to only enable what the LSP server supports
			opts.on_attach = on_attach
			vim.lsp.config(name, opts) -- nvim v0.11.0 or above required
		end
	end,
}

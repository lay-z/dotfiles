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
		-- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		-- for type, icon in pairs(signs) do
		-- 	local hl = "DiagnosticSign" .. type
		-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		-- end

		-- configure html server
		-- lspconfig["html"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		-- configure typescript server with plugin
		-- vim.lsp.config("ts_ls", {
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- })

		-- configure jsonlsp server, with access to schema store!
		-- https://github.com/b0o/SchemaStore.nvim?tab=readme-ov-file
		-- lspconfig.jsonls.setup({
		-- 	settings = {
		-- 		json = {
		-- 			schemas = require("schemastore").json.schemas(),
		-- 			validate = { enable = true },
		-- 		},
		-- 	},
		-- })

		-- configure jsonlsp server, with access to schema store!
		-- https://github.com/b0o/SchemaStore.nvim?tab=readme-ov-file
		-- lspconfig.yamlls.setup({
		-- 	settings = {
		-- 		yaml = {
		-- 			schemaStore = {
		-- 				-- You must disable built-in schemaStore support if you want to use
		-- 				-- this plugin and its advanced options like `ignore`.
		-- 				enable = false,
		-- 				-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
		-- 				url = "",
		-- 			},
		-- 			schemas = require("schemastore").yaml.schemas(),
		-- 		},
		-- 	},
		-- })

		-- 		-- configure css server
		-- 		lspconfig["cssls"].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 		})
		--
		-- 		lspconfig["bashls"].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 		})
		--
		-- 		-- lspconfig["rust_analyzer"].setup({
		-- 		-- 	capabilities = capabilities,
		-- 		-- 	-- on_attach = on_attach,
		-- 		-- 	on_attach = function(client, bufnr)
		-- 		-- 		vim.lsp.inlay_hint.enable(true)
		-- 		-- 		on_attach(client, bufnr)
		-- 		-- 	end,
		-- 		-- })
		-- 		vim.g.rustaceanvim.server.on_attach = function(client, bufnr)
		-- 			-- vim.lsp.inlay_hints({ prefix = " » ", highlight = "Comment" })
		-- 			on_attach(client, bufnr)
		-- 		end
		--
		-- 		-- configure svelte server
		-- 		-- lspconfig["svelte"].setup({
		-- 		--   capabilities = capabilities,
		-- 		--   on_attach = function(client, bufnr)
		-- 		--     on_attach(client, bufnr)
		-- 		--
		-- 		--     vim.api.nvim_create_autocmd("BufWritePost", {
		-- 		--       pattern = { "*.js", "*.ts" },
		-- 		--       callback = function(ctx)
		-- 		--         if client.name == "svelte" then
		-- 		--           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
		-- 		--         end
		-- 		--       end,
		-- 		--     })
		-- 		--   end,
		-- 		-- })
		--
		-- 		-- -- configure graphql language server
		-- 		-- lspconfig["graphql"].setup({
		-- 		--   capabilities = capabilities,
		-- 		--   on_attach = on_attach,
		-- 		--   filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		-- 		-- })
		--
		-- 		-- configure emmet language server
		-- 		lspconfig["emmet_ls"].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		-- 		})
		--
		-- 		-- configure python server
		-- 		lspconfig["pyright"].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 		})
		--
		-- 		-- configure lua server (with special settings)
		-- 		lspconfig["lua_ls"].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 			settings = { -- custom settings for lua
		-- 				Lua = {
		-- 					-- make the language server recognize "vim" global
		-- 					diagnostics = {
		-- 						globals = { "vim" },
		-- 					},
		-- 					workspace = {
		-- 						-- make language server aware of runtime files
		-- 						library = {
		-- 							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
		-- 							[vim.fn.stdpath("config") .. "/lua"] = true,
		-- 						},
		-- 					},
		-- 					hint = {
		-- 						enabled = true,
		-- 					},
		-- 				},
		-- 			},
		-- 		})
		--
		-- 		-- solidity babay
		-- 		lspconfig["solidity_ls_nomicfoundation"].setup({
		-- 			on_attach = on_attach,
		-- 		})
		--
		-- 		-- TODO need to figure out why ruby_ls doesn't work :sob:
		-- 		-- For some reason its in the config, but just doesn't work as expected
		-- 		-- require("lspconfig").ruby_ls.setup({
		-- 		-- 	-- capabilities = capabilities,
		-- 		-- 	on_attach = on_attach,
		-- 		-- 	root_dir = require("lspconfig.util").root_pattern("*gemfile"),
		-- 		-- 	-- root_pattern = { "gemfile", ".git", ".exercism", "test" },
		-- 		-- })
		--
		-- 		lspconfig["solargraph"].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 			root_dir = require("lspconfig.util").root_pattern("gemfile", ".git", ".exercism"),
		-- 			-- root_pattern = { "gemfile", ".git", ".exercism" },
		-- 		})
		--
		-- 		lspconfig["gopls"].setup({
		-- 			capabilities = capabilities,
		-- 			on_attach = on_attach,
		-- 			-- root_pattern = { "gemfile", ".git", ".exercism" },
		-- 		})
		-- 	end,
		-- }

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

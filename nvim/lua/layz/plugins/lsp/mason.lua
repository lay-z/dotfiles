return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"tsserver",
				"ts_ls",
				"html",
				"cssls",
				-- "tailwindcss",
				-- "svelte",
				"lua_ls",
				-- "graphql",
				-- "emmet_ls",
				-- "prismals",
				"pyright",
				"bashls",
				"solidity_ls_nomicfoundation",
				"gopls",
				"shfmt",
				"yaml-language-server",
				"jsonls",
				"shfmt",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js linter
				"codelldb", -- for debugging rust application https://github.com/mrcjkb/rustaceanvim?tab=readme-ov-file#using-codelldb-for-debugging
			},
		})
	end,
}

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

		local lsp_servers = {
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
			"bash-language-server",
			"solidity_ls_nomicfoundation",
			"shfmt",
			"yaml-language-server",
			"jsonls",
			"shfmt",
		}

		local mason_tools = {
			"prettier", -- prettier formatter
			"stylua", -- lua formatter
			"isort", -- python formatter
			"black", -- python formatter
			"pylint", -- python linter
			"eslint_d", -- js linter
		}

		if vim.fn.executable("go") == 1 then
			table.insert(lsp_servers, "gopls")
		end

		-- if vim.fn.executable("cargo") == 1 then
		-- 	table.insert(lsp_servers, "rust_analyzer")
		-- 	table.insert(mason_tools, "codelldb") -- for debugging rust application https://github.com/mrcjkb/rustaceanvim?tab=readme-ov-file#using-codelldb-for-debugging
		-- end

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = lsp_servers, -- ensure these servers are installed
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
			-- Get it so that rust_analyzer is not installed by mason
			-- https://github.com/mrcjkb/rustaceanvim/blob/af4de6a35d128ce71c75a9a7846bf089aea76f50/doc/mason.txt#L4-L8
			rust_analyzer = function()
				return true
			end,
		})

		mason_tool_installer.setup({
			ensure_installed = mason_tools,
		})
	end,
}

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				PATH = "prepend",
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd", "pylsp", "quick_lint_js", "golangci_lint_ls" },
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Define on_attach function
			local on_attach = function(client, bufnr)
				client.server_capabilities.signatureHelpProvider = false

				-- Define keymap options
				local opts = { noremap = true, silent = true, buffer = bufnr }

				-- Set keymaps
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			end

			-- Setup LSP servers
			lspconfig.lua_ls.setup({ on_attach = on_attach })
			lspconfig.clangd.setup({ on_attach = on_attach })
			lspconfig.pylsp.setup({ on_attach = on_attach })
			lspconfig.quick_lint_js.setup({ on_attach = on_attach })
			lspconfig.golangci_lint_ls.setup({ on_attach = on_attach })
		end,
	},
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		opts = {
			servers = {
				svelte = {
					on_attach = function(client)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				},
			},

			setup = {
				svelte = function(_, opts)
					local lspconfig = require("lspconfig")
					local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
					local capabilities = require("cmp_nvim_lsp").default_capabilities()

					lsp_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
					lsp_capabilities.textDocument.completion = capabilities.textDocument.completion

					opts.capabilities = capabilities
					lspconfig.svelte.setup(opts)
				end,
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "svelte", "scss" })
		end,
	},
}

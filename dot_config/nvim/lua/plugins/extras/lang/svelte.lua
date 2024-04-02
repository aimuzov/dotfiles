return {
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,

		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "svelte" })
			end
		end,
	},

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
								if client.name == "svelte" then
									client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
								end
							end,
						})
					end,
				},
			},
			setup = {
				svelte = function(_, opts)
					local lspconfig = require("lspconfig")
					local cmp_nvim_lsp = require("cmp_nvim_lsp")
					local capabilities = cmp_nvim_lsp.default_capabilities()

					opts.capabilities = capabilities
					lspconfig.svelte.setup(opts)
				end,
			},
		},
	},
}

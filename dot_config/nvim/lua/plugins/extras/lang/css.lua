local cssls_setup = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities.textDocument.completion.completionItem.snippetSupport = true
	require("lspconfig").cssls.setup({ capabilities = capabilities })

	return true
end

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = { cssls = {} },
			setup = { cssls = cssls_setup },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "css" })
		end,
	},
}

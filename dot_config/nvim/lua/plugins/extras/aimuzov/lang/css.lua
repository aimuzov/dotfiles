local cssls_setup = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities.textDocument.completion.completionItem.snippetSupport = true

	require("lspconfig").cssls.setup({
		capabilities = capabilities,
	})

	return true
end

return {
	{
		"nvim-treesitter/nvim-treesitter",

		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "css", "scss" })
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",

		opts = {
			servers = { cssls = {} },
			setup = { cssls = cssls_setup },
		},
	},
}

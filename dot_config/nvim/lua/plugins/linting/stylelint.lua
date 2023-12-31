return {
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = { servers = { stylelint_lsp = { filetypes = { "css", "svelte" } } } },
	},
}

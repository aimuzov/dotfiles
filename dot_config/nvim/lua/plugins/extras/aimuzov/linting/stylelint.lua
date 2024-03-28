return {
	{
		"neovim/nvim-lspconfig",
		opts = { servers = { stylelint_lsp = { filetypes = { "css", "svelte" } } } },
	},
}

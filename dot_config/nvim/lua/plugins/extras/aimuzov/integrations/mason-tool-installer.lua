local ensure_installed = {
	"cssls",
	"emmet_language_server",
	"eslint",
	"eslint_d",
	"html",
	"js-debug-adapter",
	"jsonls",
	"lua_ls",
	"prettierd",
	"shfmt",
	"stylelint_lsp",
	"stylua",
	"svelte",
	"tsserver",
}

return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,

		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},

		opts = {
			ensure_installed = ensure_installed,
			auto_update = true,
		},
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
	},
}

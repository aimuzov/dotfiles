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
		"williamboman/mason.nvim",
		optional = true,
		opts = { ui = { border = "rounded", width = 0.7, height = 0.7 } },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		optional = true,
		opts = { ensure_installed = ensure_installed },
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		optional = true,
		opts = { ensure_installed = ensure_installed, auto_update = true, start_delay = 500 },
	},
}

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
		opts = { ui = { border = "rounded", width = 0.6, height = 0.7 } },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		optional = true,
	},
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
		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
		optional = true,
	},
}

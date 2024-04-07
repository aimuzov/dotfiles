return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		opts = { auto_update = true },
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,
		dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
	},
}

return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			auto_update = true,
			ensure_installed = {},
			integrations = {
				["mason-null-ls"] = false,
				["mason-nvim-dap"] = false,
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = function(_, opts)
			for key, _ in pairs(require("lspconfig.configs")) do
				table.insert(opts.ensure_installed, key)
			end
		end,
	},
}

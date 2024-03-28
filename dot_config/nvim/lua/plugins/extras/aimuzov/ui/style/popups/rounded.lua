return {
	{
		"rcarriga/nvim-dap-ui",
		optional = true,
		opts = { floating = { border = "rounded" } },
	},

	{
		"lewis6991/gitsigns.nvim",
		optional = true,
		opts = { preview_config = { border = "rounded" } },
	},

	{
		"williamboman/mason.nvim",
		optional = true,
		opts = { ui = { border = "rounded" } },
	},

	{
		"neovim/nvim-lspconfig",
		optional = true,

		opts = {
			diagnostics = {
				float = { border = "rounded" },
			},
		},

		init = function()
			require("lspconfig.ui.windows").default_options.border = "rounded"
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = { popup_border_style = "rounded" },
	},
}

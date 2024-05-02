return {
	{
		"neovim/nvim-lspconfig",
		opts = { servers = { emmet_language_server = {} } },
	},

	{
		"olrtg/nvim-emmet",
		keys = {
			{
				"<leader>xe",
				[[<cmd>lua require("nvim-emmet").wrap_with_abbreviation()<cr>]],
				desc = "Wrap with emmet abbreviation",
				mode = { "n", "v" },
			},
		},
	},
}

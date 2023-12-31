return {
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				emmet_language_server = {
					filetypes = {
						"css",
						"eruby",
						"html",
						"javascript",
						"javascriptreact",
						"svelte",
						"typescriptreact",
					},
				},
			},
		},
	},

	{
		"olrtg/nvim-emmet",
		optional = true,
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

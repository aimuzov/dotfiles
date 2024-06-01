return {
	{
		"folke/trouble.nvim",
		opts = { focus = true },

		keys = {
			{
				"gR",
				[[<cmd>lua require("trouble").open("lsp_references")<cr>]],
				mode = { "n" },
				desc = "Show all references",
			},
		},
	},
}

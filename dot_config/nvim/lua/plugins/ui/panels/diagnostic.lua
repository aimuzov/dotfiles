return {
	{
		"folke/trouble.nvim",
		optional = true,
		opts = { auto_close = false },
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

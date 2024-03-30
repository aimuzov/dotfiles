return {
	{
		"folke/trouble.nvim",
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

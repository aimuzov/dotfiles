return {
	"Almo7aya/openingh.nvim",

	keys = {
		{
			"<leader>go",
			"<cmd>OpenInGHFile<cr>",
			desc = "Open in github/gitlab",
			mode = { "n" },
		},

		{
			"<leader>go",
			"<esc><cmd>'<,'>OpenInGHFileLines<cr>",
			desc = "Open in github/gitlab",
			mode = { "v" },
		},
	},
}

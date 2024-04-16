return {
	{
		"mcauley-penney/visual-whitespace.nvim",
		opts = { highlight = { link = "VisualWhitespace" } },
	},

	{
		"mcauley-penney/visual-whitespace.nvim",
		opts = function(_, opts)
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = vim.schedule_wrap(function()
					require("visual-whitespace").setup(opts)
				end),
			})
		end,
	},
}

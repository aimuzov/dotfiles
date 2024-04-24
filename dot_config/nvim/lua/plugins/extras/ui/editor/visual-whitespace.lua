local listchars = vim.opt.listchars:get()

return {
	{
		"mcauley-penney/visual-whitespace.nvim",
		opts = {
			highlight = { link = "VisualWhitespace" },
			space_char = listchars.space,
			tab_char = listchars.tab,
			nl_char = "↩",
		},
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

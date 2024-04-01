return {
	{
		"stevearc/aerial.nvim",
		optional = true,
		dependencies = { "LazyVim/LazyVim" },
		opts = {
			guides = {
				mid_item = "├╴  ",
				last_item = "╰╴  ",
				nested_top = "│  ",
				whitespace = "   ",
			},
		},
	},
}

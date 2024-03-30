return {
	{ import = "lazyvim.plugins.extras.editor.aerial" },

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

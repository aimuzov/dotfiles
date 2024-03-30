return {
	{
		"RRethy/vim-illuminate",
		opts = {
			delay = 250,
			providers = { "lsp", "treesitter", "regex" },
			filetypes_denylist = { "alpha", "aerial", "markdown", "neo-tree", "toggleterm", "DiffviewFiles", "Glance" },
			min_count_to_highlight = 2,
		},
	},
}

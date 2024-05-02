return {
	{
		"RRethy/vim-illuminate",
		opts = {
			delay = 250,
			providers = { "lsp", "treesitter", "regex" },
			filetypes_denylist = { "alpha", "aerial", "markdown", "neo-tree", "lazyterm", "DiffviewFiles", "Glance" },
			modes_denylist = { "v", "V" },
			min_count_to_highlight = 2,
		},
	},
}

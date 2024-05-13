return {
	{
		"lewis6991/satellite.nvim",
		opts = {
			current_only = true,
			zindex = 30,
			handlers = { diagnostic = { enable = false } },
			excluded_filetypes = {
				"alpha",
				"neo-tree",
				"neotest-summary",
				"aerial",
				"noice",
				"chatgpt-input",
				"neo-tree-preview",
			},
		},
	},
}

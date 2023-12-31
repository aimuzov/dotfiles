return {
	{
		"lukas-reineke/indent-blankline.nvim",
		optional = true,
		opts = {
			indent = { char = "│", tab_char = "│" },
			scope = { enabled = true, show_start = false, show_end = false },
		},
	},

	{
		"lukas-reineke/virt-column.nvim",
		event = "VimEnter",
		optional = true,
		opts = {
			char = "│",
			highlight = "IblIndent",
			virtcolumn = "+1,120",
			exclude = { filetypes = { "alpha" } },
		},
	},
}

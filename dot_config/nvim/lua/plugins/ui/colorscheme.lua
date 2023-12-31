return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,

		opts = {
			integrations = {
				navic = false,
				treesitter_context = true,
				dap = { enabled = true, enable_ui = true },
			},
		},
	},
}

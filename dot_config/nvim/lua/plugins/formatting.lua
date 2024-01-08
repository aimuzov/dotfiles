return {
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["svelte"] = { "stylelint", "prettier" },
				["css"] = { "stylelint", "prettier" },
				["typescript"] = { "prettier", "lsp" },
				["zsh"] = { "shfmt" },
			},
		},
	},
}

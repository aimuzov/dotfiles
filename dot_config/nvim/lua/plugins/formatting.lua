local prettier_list = { "prettierd", "prettier" }

return {
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				["svelte"] = { prettier_list, "stylelint" },
				["css"] = { prettier_list, "stylelint" },
				["typescript"] = { prettier_list, "lsp" },
				["zsh"] = { "shfmt" },
			},
		},
	},
}

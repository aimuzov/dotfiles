local prettier_list = { "prettierd", "prettier" }

return {
	"stevearc/conform.nvim",
	optional = true,
	opts = {
		formatters_by_ft = {
			["c"] = { "clang_format" },
			["css"] = { prettier_list, "stylelint" },
			["svelte"] = { prettier_list, "stylelint" },
			["typescript"] = { prettier_list, "lsp" },
			["zsh"] = { "shfmt" },
		},
	},
}

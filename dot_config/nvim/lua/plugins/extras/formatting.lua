return {
	"stevearc/conform.nvim",
	optional = true,
	opts = function(_, opts)
		opts.formatters_by_ft["c"] = { "clang_format" }
		opts.formatters_by_ft["svelte"] = { "prettier", "stylelint" }
		opts.formatters_by_ft["zsh"] = { "shfmt" }

		vim.list_extend(opts.formatters_by_ft["css"], { "stylelint" })
		vim.list_extend(opts.formatters_by_ft["typescript"], { "lsp" })
	end,
}

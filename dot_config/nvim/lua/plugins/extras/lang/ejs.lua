return {
	{
		"nvim-treesitter/nvim-treesitter",

		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "embedded_template" })
			vim.treesitter.language.register("eruby", { "ejs" })
			vim.filetype.add({ extension = { ejs = "eruby" } })
		end,
	},
}

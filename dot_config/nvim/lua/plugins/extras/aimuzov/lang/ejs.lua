return {
	{
		"nvim-treesitter/nvim-treesitter",

		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "embedded_template" })
			end

			vim.treesitter.language.register("eruby", "ejs")
		end,
	},
}

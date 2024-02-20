return {
	{
		"mfussenegger/nvim-lint",
		optional = true,

		opts = function(_, opts)
			if vim.fn.executable("cspell") == 1 then
				opts.linters_by_ft["*"] = { "cspell" }
			end

			return opts
		end,
	},
}

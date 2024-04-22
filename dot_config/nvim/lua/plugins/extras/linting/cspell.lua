return {
	{
		"mfussenegger/nvim-lint",

		opts = function(_, opts)
			if vim.fn.executable("cspell") == 0 then
				return
			end

			opts.linters_by_ft["*"] = opts.linters_by_ft["*"] or {}
			table.insert(opts.linters_by_ft["*"], "cspell")
		end,
	},
}

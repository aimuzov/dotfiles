return {
	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = { "haydenmeade/neotest-jest" },

		opts = function(_, opts)
			table.insert(
				opts.adapters,
				require("neotest-jest")({
					env = { CI = true },
					cwd = function()
						return vim.fn.getcwd()
					end,
				})
			)
		end,

		config = true,
	},
}

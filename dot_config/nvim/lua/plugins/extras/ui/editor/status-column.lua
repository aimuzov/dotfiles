return {
	{
		"lewis6991/gitsigns.nvim",
		opts = { numhl = true },
	},

	{
		"luukvbaal/statuscol.nvim",
		branch = "0.10",
		opts = function(_, opts)
			local builtin = require("statuscol.builtin")

			opts.relculright = true
			opts.segments = {
				{ text = { "%C" }, click = "v:lua.ScFa" },
				{
					text = { builtin.lnumfunc, " " },
					condition = { true, builtin.not_empty },
					click = "v:lua.ScLa",
				},
				{
					sign = { namespace = { "diagnostic" } },
					click = "v:lua.ScSa",
					text = { "%s" },
				},
			}
		end,
	},
}

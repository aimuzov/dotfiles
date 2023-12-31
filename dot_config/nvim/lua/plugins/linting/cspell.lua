return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "davidmh/cspell.nvim" },
		optional = true,

		opts = function(_, opts)
			if vim.fn.executable("cspell") == 1 then
				local cspell = require("cspell")
				local cspell_config = { config_file_preferred_name = "cspell.config.json" }

				table.insert(opts.sources, cspell.diagnostics.with({ config = cspell_config }))
				table.insert(opts.sources, cspell.code_actions.with({ config = cspell_config }))
			end
		end,
	},
}

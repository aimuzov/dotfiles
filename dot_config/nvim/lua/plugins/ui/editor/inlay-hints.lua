return {
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			diagnostics = {
				underline = false,
				virtual_text = { spacing = 0, prefix = "▎", suffix = " " },
			},
		},
		init = function()
			require("lspconfig.ui.windows").default_options.border = "rounded"
		end,
	},

	{
		"Wansmer/symbol-usage.nvim",
		event = "BufReadPre",
		optional = true,
		opts = function(_, opts)
			opts.vt_position = "end_of_line"
			opts.request_pending_text = "symbol"
			opts.hl = { link = "GitSignsCurrentLineBlame" }
			opts.text_format = function(symbol)
				local text = require("symbol-usage.options")._default_opts.text_format(symbol)

				return "󰌹 " .. text
			end
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		optional = true,
		opts = {
			current_line_blame = true,
			current_line_blame_opts = { delay = 50 },
			current_line_blame_formatter = " 󰞗 <author>  <author_time:%R>  <summary>",
		},
	},
}

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				underline = false,
				virtual_text = { spacing = 0, prefix = "▎", suffix = " " },
			},
		},
	},

	{
		"Wansmer/symbol-usage.nvim",
		event = "BufReadPre",
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
		opts = {
			current_line_blame = true,
			current_line_blame_opts = { virt_text_pos = "right_align" },
			current_line_blame_formatter = " 󰞗 <author>  <author_time:%R>  <summary> ",
		},
	},
}

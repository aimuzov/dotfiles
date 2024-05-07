return {
	{
		"rcarriga/nvim-notify",
		opts = {
			render = "minimal",
			stages = "fade",
			minimum_width = 40,
		},
	},

	{
		"folke/noice.nvim",
		opts = {
			presets = { bottom_search = false },

			cmdline = {
				opts = {
					win_options = {
						winhighlight = {
							Normal = "NormalFloat",
							FloatBorder = "FloatBorder",
							FloatTitle = "FloatTitle",
						},
					},
				},
			},

			lsp = {

				documentation = {
					opts = {
						win_options = {
							winhighlight = {
								NormalFloat = "CmpDocFloat",
							},
						},
					},
				},
			},

			format = {
				spinner = {
					name = "triangle",
				},
			},

			routes = {
				{
					view = "mini",
					opts = { skip = true },
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
							{ find = "%d fewer lines" },
							{ find = "%d more lines" },
						},
					},
				},
				{
					view = "notify",
					filter = {
						any = {
							{ find = "Reloading" },
							{ find = "No items, skipping git ignored/status lookups" },
						},
					},
					opts = { skip = true },
				},
				{
					filter = {
						any = {
							{ find = "No information available" },
						},
					},
					opts = { stop = true },
				},
			},
		},
	},
}

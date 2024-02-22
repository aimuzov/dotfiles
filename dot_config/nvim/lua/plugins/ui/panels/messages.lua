return {
	{
		"rcarriga/nvim-notify",
		optional = true,
		opts = { render = "minimal", stages = "fade" },
	},

	{
		"folke/noice.nvim",
		optional = true,
		opts = {
			presets = { bottom_search = false },

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

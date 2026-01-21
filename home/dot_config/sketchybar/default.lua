local sbar = require("sketchybar")
local config = require("config")

sbar.default({
	background = {
		height = 26,
		corner_radius = 16,
		border_width = 1,
	},

	padding_left = config.paddings,
	padding_right = config.paddings,
	updates = "when_shown",

	icon = {
		font = { family = config.font, style = "Regular", size = 14 },
		color = config.colors.white,
		highlight_color = config.colors.white,
		padding_left = config.paddings,
		padding_right = config.paddings,
	},

	label = {
		font = { family = config.font, style = "Regular", size = 14 },
		color = config.colors.white,
		highlight_color = config.colors.white,
		padding_left = config.paddings,
		padding_right = config.paddings,
	},
})

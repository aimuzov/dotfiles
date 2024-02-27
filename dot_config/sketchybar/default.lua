local sbar = require("sketchybar")
local config = require("config")

sbar.default({
	background = {
		height = 26,
		corner_radius = 9,
		border_width = 1,
	},

	padding_left = config.paddings,
	padding_right = config.paddings,
	updates = "when_shown",

	icon = {
		font = {
			family = config.font,
			size = 14,
			style = "Bold",
		},
		color = config.colors.white,
		padding_left = config.paddings,
		padding_right = config.paddings,
	},

	label = {
		font = {
			family = config.font,
			style = "Semibold",
			size = 13,
		},
		color = config.colors.white,
		padding_left = config.paddings,
		padding_right = config.paddings,
	},
})

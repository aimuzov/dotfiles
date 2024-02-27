local sbar = require("sketchybar")
local config = require("config")

local bar = sbar.bar({
	border_color = config.colors.bar.border,
	color = config.colors.bar.bg,
	height = 38,
	padding_left = 8,
	padding_right = 8,
	position = "bottom",
	shadow = false,
	sticky = true,
	topmost = false,
})

return bar

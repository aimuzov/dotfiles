local sbar = require("sketchybar")
local config = require("config")

local bar = sbar.bar({
	color = config.colors.transparent,
	height = 36,
	padding_left = 4,
	padding_right = 4,
	position = "bottom",
	shadow = false,
	sticky = true,
	topmost = false,
})

return bar

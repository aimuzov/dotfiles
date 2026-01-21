local sbar = require("sketchybar")
local config = require("config")

local bar = sbar.bar({
	color = config.colors.transparent,
	height = 40,
	padding_left = 8,
	padding_right = 8,
	position = "bottom",
	shadow = false,
	sticky = true,
	topmost = false,
})

return bar

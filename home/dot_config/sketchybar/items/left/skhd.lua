local sbar = require("sketchybar")
local colors = require("config").colors

local icons = {
	window = "􀏜",
	resize = "􀄭",
	move = "􀭱",
	stack = "􃑷",
	command = "􀆔",
}

sbar.add("event", "skhd_mode_update")

local skhd = sbar.add("item", {
	display = "active",
	position = "left",
	icon = { width = 0, align = "center", padding_left = 0, padding_right = 0 },
	label = { width = 0, padding_left = 0, padding_right = 0 },
})

local function update(ENV)
	local icon = { string = "", width = 0, color = colors.black, padding_right = 0 }
	local background = { color = colors.transparent }

	if ENV.MODE == "window" then
		icon.string = icons.window
		icon.width = 44
		icon.padding_right = 2
		background.color = colors.yellow
	elseif ENV.MODE == "resize" then
		icon.string = icons.resize
		icon.width = 44
		background.color = colors.orange
	elseif ENV.MODE == "move" then
		icon.string = icons.move
		icon.width = 44
		background.color = colors.green
	elseif ENV.MODE == "stack" then
		icon.string = icons.stack
		icon.width = 44
		background.color = colors.magenta
	elseif ENV.MODE == "command" then
		icon.string = icons.command
		icon.width = 44
		background.color = colors.red
	end

	skhd:set({ icon = icon, background = background })
end

skhd:subscribe("skhd_mode_update", update)

return skhd

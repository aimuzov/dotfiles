local sbar = require("sketchybar")
local colors = require("config").colors

local icons = {
	en = "􀂕",
	ru = "􀂷",
	unknown = "􀃭",
}

local keyboard_layout = sbar.add("item", {
	icon = { font = { size = 26 } },
	padding_left = 0,
	padding_right = 0,
	display = "active",
	position = "center",
})

local function update()
	local layout = assert(io.popen("im-select"):read("a"):gsub("%s+", ""))
	local icon = {
		string = icons.unknown,
		color = colors.white,
	}

	if layout == "com.apple.keylayout.US" then
		icon.string = icons.en
	elseif layout == "com.apple.keylayout.Russian" then
		icon.string = icons.ru
		icon.color = colors.red
	end

	sbar.animate("sin", 10, function()
		keyboard_layout:set({ icon = icon })
	end)
end

sbar.add("event", "keyboard_layout_change", "AppleSelectedInputSourcesChangedNotification")
keyboard_layout:subscribe({ "forced", "keyboard_layout_change" }, update)

return keyboard_layout

local sbar = require("sketchybar")
local colors = require("config").colors

local icon_map = require("items.left.spaces.icon_map")

local spaces = {}

for i = 1, 10, 1 do
	local space = sbar.add("space", {
		icon = {
			string = i ~= 10 and i or 0,
			padding_left = 6,
			padding_right = 6,
			color = colors.white,
			highlight_color = colors.white,
		},

		label = {
			padding_left = 0,
			padding_right = 6,
			color = colors.grey,
			highlight_color = colors.grey,
			font = "Sketchybar App Font:Regular:16",
			y_offset = -1,
		},

		space = i,
		padding_left = 0,
		padding_right = 1,
		background = { color = colors.bg1 },
	})

	spaces[i] = space

	space:subscribe("space_change", function(ENV)
		local bg_color = ENV.SELECTED == "true" and colors.bg2 or colors.bg1
		local text_color = ENV.SELECTED == "true" and colors.white or colors.grey

		space:set({
			icon = { highlight = ENV.SELECTED, color = text_color },
			label = { highlight = ENV.SELECTED, highlight_color = text_color },
			background = { color = bg_color },
		})
	end)

	space:subscribe("mouse.clicked", function(ENV)
		local op = (ENV.BUTTON == "right") and "--destroy" or "--focus"
		sbar.exec("yabai -m space " .. op .. " " .. ENV.SID)
	end)
end

local space_creator = sbar.add("item", {
	label = { drawing = false },
	display = "active",
	icon = {
		string = "􀆊",
		font = { style = "Heavy", size = 12 },
		color = colors.grey,
	},
})

space_creator:subscribe("mouse.clicked", function(_)
	sbar.exec("yabai -m space --create")
end)

space_creator:subscribe("space_windows_change", function(env)
	local icon_line = ""
	local no_app = true

	for app in pairs(env.INFO.apps) do
		no_app = false
		icon_line = icon_line .. app .. " "
	end

	if no_app then
		icon_line = "􀍠"
	end

	icon_line = icon_line:gsub("%s+$", "")

	spaces[env.INFO.space]:set({ label = icon_line })
end)

return {
	spaces = spaces,
	space_creator = space_creator,
}

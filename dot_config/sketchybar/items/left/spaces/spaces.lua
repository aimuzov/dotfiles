local sbar = require("sketchybar")
local colors = require("config").colors

local app_icons = require("items.left.spaces.app_icons")

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
			font = "sketchybar-app-font:Regular:16",
			y_offset = -1,
		},

		space = i,
		padding_left = 0,
		padding_right = 1,
		background = { color = colors.bg1 },
	})

	spaces[i] = space

	local space_preview = sbar.add("item", {
		position = "popup." .. space.name,
		padding_left = 0,
		padding_right = 0,
		background = {
			drawing = true,
			image = {
				corner_radius = 9,
				border_width = 5,
				border_color = colors.green,
				scale = 0.02,
			},
		},
	})

	space:subscribe("space_change", function(ENV)
		local bg_color = ENV.SELECTED == "true" and colors.bg2 or colors.bg1
		local text_color = ENV.SELECTED == "true" and colors.white or colors.grey

		sbar.animate("sin", 10, function()
			space:set({
				icon = { highlight = ENV.SELECTED, color = text_color },
				label = { highlight = ENV.SELECTED, highlight_color = text_color },
				background = { color = bg_color },
			})
		end)
	end)

	space:subscribe("mouse.entered", function(ENV)
		sbar.animate("sin", 10, function()
			space:set({ popup = { drawing = true } })
			space_preview:set({ background = { image = "space." .. ENV.SID } })
			space_preview:set({ background = { image = { scale = 0.08 } } })
		end)
	end)

	space:subscribe("mouse.exited", function()
		space_preview:set({ background = { image = { scale = 0.02 } } })
		space:set({ popup = { drawing = false } })
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
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["default"] or lookup)
		icon_line = icon_line .. icon .. " "
	end

	if no_app then
		icon_line = "􀍠"
	end

	icon_line = icon_line:gsub("%s+$", "")

	sbar.animate("sin", 10, function()
		spaces[env.INFO.space]:set({ label = icon_line })
	end)
end)

return {
	spaces = spaces,
	space_creator = space_creator,
}

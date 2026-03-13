local sbar = require("sketchybar")
local config = require("config")
local helpers = require("helpers")

local spaces = {}

local spaces_num_icons = {
	["1"] = "􀀻",
	["2"] = "􀀽",
	["3"] = "􀀿",
	["4"] = "􀁁",
	["5"] = "􀁃",
	["6"] = "􀁅",
	["7"] = "􀁇",
	["8"] = "􀁉",
	["9"] = "􀁋",
	["10"] = "􀔔",
	["11"] = "􀔕",
	["12"] = "􀔖",
	["13"] = "􀔗",
	["14"] = "􀔘",
	["15"] = "􀔙",
	["16"] = "􀔚",
}

helpers.wait_for_yabai()

local spaces_length = tonumber(helpers.safe_exec([[yabai -m query --spaces | jq "length"]])) or 0

for i = 1, spaces_length, 1 do
	local space = sbar.add("space", {
		icon = { padding_left = 6, string = "" },
		label = { padding_right = 6, font = "Sketchybar App Font:Regular:16" },
		space = i,
		padding_left = 0,
		padding_right = 0,
		background = { color = config.colors.transparent },
	})

	spaces[i] = space

	space:subscribe("space_change", function(ENV)
		space:set({
			icon = { highlight = ENV.SELECTED },
			label = { highlight = ENV.SELECTED },
			background = { color = ENV.SELECTED == "true" and config.colors.active or config.colors.transparent },
		})
	end)

	space:subscribe("mouse.clicked", function(ENV)
		local op = (ENV.BUTTON == "right") and "--destroy" or "--focus"
		sbar.exec("yabai -m space " .. op .. " " .. ENV.SID)
	end)

	space:subscribe("space_windows_change", function(env)
		local space_item = spaces[env.INFO.space]

		if not space_item then
			return
		end

		local icon_name = spaces_num_icons[tostring(env.INFO.space)] or ""
		local icon_line = ""

		for app in pairs(env.INFO.apps) do
			icon_line = icon_line .. app .. " "
		end

		if icon_line == "" then
			local label =
				helpers.safe_exec([[yabai -m query --spaces | jq -r '.[]] .. env.INFO.space - 1 .. [[].label']])

			if label then
				icon_name = icon_name .. " " .. label
			end
		end

		space_item:set({
			icon = { string = icon_name },
			label = {
				string = icon_line,
				padding_left = icon_line == "" and 0 or 3,
			},
		})
	end)
end

return { spaces = spaces }

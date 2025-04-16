local sbar = require("sketchybar")
local colors = require("config").colors

local spaces = {}

local spaces_length = io.popen([[yabai -m query --spaces | jq "length"]]):read("a"):gsub("%s+", "")

local spaces_num_icons = {
	["1"] = "􀃋",
	["2"] = "􀃍",
	["3"] = "􀃏",
	["4"] = "􀘚",
	["5"] = "􀃓",
	["6"] = "􀃕",
	["7"] = "􀃗",
	["8"] = "􀃙",
	["9"] = "􀃛",
	["10"] = "􀕒",
	["11"] = "􀕓",
	["12"] = "􀕔",
	["13"] = "􀕕",
	["14"] = "􀕖",
	["15"] = "􀕗",
	["16"] = "􀕘",
}

for i = 1, spaces_length, 1 do
	local space = sbar.add("space", {
		icon = {
			string = "",
			padding_right = 3,
			padding_left = 6,
			color = colors.white,
			highlight_color = colors.white,
		},

		label = {
			padding_left = 3,
			padding_right = 6,
			color = colors.grey,
			highlight_color = colors.grey,
			font = "Sketchybar App Font:Regular:16",
		},

		space = i,
		padding_left = 0,
		padding_right = 0,
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

	space:subscribe("space_windows_change", function(env)
		local icon_name = spaces_num_icons[tostring(env.INFO.space)]
		local icon_line = ""

		for app in pairs(env.INFO.apps) do
			icon_line = icon_line .. app .. " "
		end

		if icon_line == "" then
			icon_name = icon_name
				.. " "
				.. io.popen([[yabai -m query --spaces | jq -r '.[]] .. env.INFO.space - 1 .. [[].label']]):read("a")
		end

		spaces[env.INFO.space]:set({
			icon = { string = icon_name },
			label = {
				string = icon_line,
				padding_left = icon_line == "" and 0 or 3,
			},
		})
	end)
end

return { spaces = spaces }

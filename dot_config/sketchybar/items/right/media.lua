local sbar = require("sketchybar")
local colors = require("config").colors

local whitelist = { ["Яндекс Музыка"] = true }

local media = sbar.add("item", {
	icon = { width = 20 },
	position = "right",
	updates = true,
})

media:subscribe("media_change", function(env)
	local is_playing = env.INFO.state == "playing"
	local color = is_playing and colors.white or colors.grey
	local drawing = whitelist[env.INFO.app] == true and env.INFO.artist ~= ""

	local label = {
		string = env.INFO.artist .. " / " .. env.INFO.title,
		color = color,
	}

	local icon = {
		string = is_playing and "􀊄" or "􀊆",
		color = color,
	}

	sbar.animate("sin", 10, function()
		media:set({ drawing = drawing, icon = icon, label = label })
	end)
end)

return media

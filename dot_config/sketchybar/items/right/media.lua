local sbar = require("sketchybar")
local colors = require("config").colors

local whitelist = {
	["Google Chrome"] = true,
	["Yandex Music"] = true,
}

local click_script = "nowplaying-cli togglePlayPause"

local media_icon = sbar.add("item", {
	icon = { width = 18 },
	label = { drawing = false },
	position = "right",
	updates = true,
	click_script = click_script,
})

local media_artist = sbar.add("item", {
	position = "right",
	width = 0,
	icon = { drawing = false },
	label = { width = 0, y_offset = 6, font = { size = 9 } },
	click_script = click_script,
})

local media_title = sbar.add("item", {
	position = "right",
	icon = { drawing = false },
	label = { width = 0, y_offset = -5, font = { size = 11 } },
	click_script = click_script,
})

local interrupt = 0

local function animate_detail(detail)
	if not detail then
		interrupt = interrupt - 1
	end

	if interrupt > 0 and not detail then
		return
	end

	sbar.animate("tanh", 30, function()
		media_artist:set({ label = { width = detail and "dynamic" or 0 } })
		media_title:set({ label = { width = detail and "dynamic" or 0 } })
	end)
end

media_icon:subscribe("media_change", function(env)
	local is_playing = env.INFO.state == "playing"
	local color = is_playing and colors.white or colors.grey
	local drawing = whitelist[env.INFO.app] == true and env.INFO.artist ~= ""

	sbar.animate("sin", 10, function()
		media_icon:set({
			drawing = drawing,
			icon = { color = color, string = is_playing and "􀊄" or "􀊆" },
		})

		media_artist:set({
			drawing = drawing,
			label = { color = color, string = env.INFO.artist },
		})

		media_title:set({
			drawing = drawing,
			label = { color = color, string = env.INFO.title },
		})
	end)

	if drawing then
		animate_detail(true)
		interrupt = interrupt + 1
		sbar.delay(5, animate_detail)
	end
end)

media_icon:subscribe("mouse.entered", function(env)
	interrupt = interrupt + 1
	animate_detail(true)
end)

media_icon:subscribe("mouse.exited", function(env)
	animate_detail(false)
end)

return media_icon

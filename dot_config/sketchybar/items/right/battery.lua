local sbar = require("sketchybar")
local colors = require("config").colors

local icons = {
	percents_100 = "􀛨",
	percents_75 = "􀺸",
	percents_50 = "􀺶",
	percents_25 = "􀛩",
	percents_0 = "􀛪",
	charging = "􀢋",
}

local battery = sbar.add("item", {
	position = "right",
	label = { drawing = true },
	update_freq = 120,
})

local function update()
	local file = assert(io.popen("pmset -g batt"))
	local batt_info = assert(file:read("a"))
	local found, _, charge = batt_info:find("(%d+)%%")

	local label = ""
	local icon = { string = "!", color = colors.white }

	if found then
		charge = tonumber(charge)
		label = charge .. "%"

		if charge > 80 then
			icon.string = icons.percents_100
		elseif charge > 60 then
			icon.string = icons.percents_75
		elseif charge > 40 then
			icon.string = icons.percents_50
			icon.color = colors.yellow
		elseif charge > 20 then
			icon.string = icons.percents_25
			icon.color = colors.orange
		elseif charge > 0 then
			icon.string = icons.percents_0
			icon.color = colors.red
		end
	end

	if string.find(batt_info, "AC Power") then
		icon.string = icons.charging
	end

	battery:set({ icon = icon, label = label })
end

battery:subscribe({ "routine", "power_source_change", "system_woke" }, update)

return battery

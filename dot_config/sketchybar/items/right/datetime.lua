local sbar = require("sketchybar")

local datetime = sbar.add("item", {
	icon = { font = { style = "Regular", size = 12.0 } },
	position = "right",
	update_freq = 30,
})

local function update()
	local date = os.date("%a %d %b")
	local time = os.date("%H:%M")

	datetime:set({ icon = date, label = time })
end

local function toggle()
	local battery = require("items.right.battery")
	local brew = require("items.right.deps")
	local nvim = require("items.right.nvim")
	local spaces = require("items.left.spaces.spaces").spaces

	local drawing = battery:query().label.drawing ~= "on"

	battery:set({ label = { drawing = drawing } })
	datetime:set({ icon = { drawing = drawing } })
	brew:set({ drawing = drawing })
	nvim:set({ drawing = drawing })

	for i in pairs(spaces) do
		spaces[i]:set({ label = { drawing = drawing } })
	end
end

datetime:subscribe({ "routine", "forced" }, update)
datetime:subscribe("mouse.clicked", toggle)

return datetime

local sbar = require("sketchybar")

local datetime = sbar.add("item", {
	position = "right",
	update_freq = 30,
	label = { font = { style = "Semibold" } },
})

local function update()
	local date = os.date("%a %d %b")
	local time = os.date("%H:%M")

	datetime:set({ icon = date, label = time })
end

datetime:subscribe({ "routine", "forced" }, update)

return datetime

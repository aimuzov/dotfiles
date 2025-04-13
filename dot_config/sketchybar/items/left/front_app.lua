local sbar = require("sketchybar")

local front_app = sbar.add("item", {
	icon = { drawing = false },
	display = "active",
	position = "left",
})

local function update(env)
	front_app:set({ label = { string = env.INFO } })
end

local function action()
	sbar.exec("open -a 'Mission Control'")
end

front_app:subscribe("front_app_switched", update)
front_app:subscribe("mouse.clicked", action)

return front_app

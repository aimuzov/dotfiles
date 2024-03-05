local sbar = require("sketchybar")
local colors = require("config").colors

local brew = sbar.add("item", {
	icon = { string = "􀐛" },

	label = {
		align = "center",
		color = colors.grey,
		string = "􀍠",
		width = 18,
	},

	position = "right",
	update_freq = 60 * 60,
})

local function action()
	sbar.exec([[wezterm start -- zsh -c "brew upgrade"]])
end

local function update()
	local file = assert(io.popen("brew outdated | wc -l | tr -d ' '"))
	local brew_info = assert(file:read("a"))
	local count = tonumber(brew_info)
	local icon = { color = colors.white }
	local label = { string = tostring(count), color = colors.white, drawing = true }

	if count == 0 then
		label.drawing = false
	elseif count < 9 then
		icon.color = colors.yellow
	elseif count < 19 then
		icon.color = colors.orange
	else
		icon.color = colors.red
	end

	sbar.animate("sin", 10, function()
		brew:set({ label = label, icon = icon })
	end)
end

brew:subscribe({ "forced", "routine", "brew_update", "update" }, update)
brew:subscribe("mouse.clicked", action)

return brew

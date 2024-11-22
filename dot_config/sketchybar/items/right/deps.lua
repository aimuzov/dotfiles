local sbar = require("sketchybar")
local colors = require("config").colors

local brew = sbar.add("item", {
	icon = { string = "􀐙" },

	label = {
		align = "center",
		color = colors.grey,
		string = "􀍠",
	},

	position = "right",
	update_freq = 60 * 60,
})

local function action()
	sbar.exec([[wezterm start -- zsh -c "brew upgrade && mise upgrade"]])
end

local function update()
	local brew_file = assert(io.popen("brew outdated | wc -l | tr -d ' '"))
	local brew_info = assert(brew_file:read("*a"))
	local brew_count = tonumber(brew_info)

	local mise_file = assert(io.popen("mise outdated --json --quiet | jq 'keys | length'"))
	local mise_info = assert(mise_file:read("*a"))
	local mise_count = tonumber(mise_info) ~= nil and tonumber(mise_info) or 0

	local count = brew_count + mise_count
	local icon = { color = colors.white }
	local label = { string = brew_count .. " • " .. mise_count, color = colors.white, drawing = true }

	if count == 0 then
		label.drawing = false
	elseif count < 5 then
		icon.color = colors.yellow
	elseif count < 10 then
		icon.color = colors.orange
	else
		icon.color = colors.red
	end

	sbar.animate("sin", 10, function()
		brew:set({ label = label, icon = icon })
	end)
end

brew:subscribe({ "forced", "routine", "update", "deps_update" }, update)
brew:subscribe("mouse.clicked", action)

return brew

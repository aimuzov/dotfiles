local sbar = require("sketchybar")
local colors = require("config").colors

local deps = sbar.add("item", {
	icon = { string = "􀐙" },
	position = "right",
	update_freq = 60 * 60,

	popup = {
		align = "right",
		background = {
			corner_radius = 9,
			border_width = 5,
			border_color = colors.blue,
			color = colors.black,
		},
	},
})

local deps_brew = sbar.add("item", {
	position = "popup." .. deps.name,
	padding_left = 10,
	padding_right = 10,
	label = "",
})

local deps_mise = sbar.add("item", {
	position = "popup." .. deps.name,
	padding_left = 10,
	padding_right = 10,
	label = "",
})

deps:subscribe("mouse.entered", function(ENV)
	sbar.animate("sin", 10, function()
		deps:set({ popup = { drawing = true } })
	end)
end)

deps:subscribe("mouse.exited", function()
	deps:set({ popup = { drawing = false } })
end)

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

	if count < 5 then
		icon.color = colors.yellow
	elseif count < 10 then
		icon.color = colors.orange
	else
		icon.color = colors.red
	end

	deps_brew:set({ label = "brew: " .. brew_count })
	deps_mise:set({ label = "mise: " .. mise_count })

	sbar.animate("sin", 10, function()
		deps:set({ icon = icon })
	end)
end

deps:subscribe({ "forced", "routine", "update", "deps_update" }, update)
deps:subscribe("mouse.clicked", action)

return deps

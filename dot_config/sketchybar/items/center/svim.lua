local sbar = require("sketchybar")
local colors = require("config").colors

local icons = {
	normal = "􀂯",
	insert = "􀂥",
	visual = "􀂿",
	cmd = "􀂙",
	pending = "􀈏",
}

local svim = sbar.add("item", {
	width = 30,
	padding_left = 0,
	padding_right = 0,

	icon = {
		align = "left",
		font = { size = 26 },
		padding_left = 0,
		padding_right = 9,
	},

	label = {
		align = "left",
		font = { size = 16 },
		width = 300,
	},

	updates = true,
	position = "center",
	display = "active",
})

local function update(ENV)
	local icon = { string = "", color = colors.white }
	local label = { string = "", drawing = false }

	if ENV.MODE == "I" then
		icon.string = icons.insert
		icon.color = colors.green
	elseif ENV.MODE == "N" then
		icon.string = icons.normal
		icon.color = colors.blue
	elseif ENV.MODE == "V" then
		icon.string = icons.visual
		icon.color = colors.magenta
	elseif ENV.MODE == "C" then
		icon.string = icons.cmd
		icon.color = colors.orange
		label.drawing = true
		label.string = ENV.CMDLINE
	elseif ENV.MODE == "_" then
		icon.string = icons.pending
	end

	sbar.animate("sin", 10, function()
		svim:set({ icon = icon, label = label })
	end)
end

svim:subscribe({ "svim_update", "window_focus" }, update)

return svim

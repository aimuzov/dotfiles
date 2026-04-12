local sbar = require("sketchybar")
local colors = require("config").colors
local helpers = require("helpers")

local kb_icons = {
	en = "􀀅",
	ru = "􀀦",
	unknown = "􀁝",
}

local svim_icons = {
	N = "􀀞",
	I = "􀀔",
	V = "􀀮",
	C = "􀀈",
	["_"] = "􀍷",
}

local svim_colors = {
	N = colors.blue,
	I = colors.green,
	V = colors.magenta,
	C = colors.orange,
	["_"] = colors.magenta,
}

sbar.add("event", "keyboard_layout_change", "AppleSelectedInputSourcesChangedNotification")

local input = sbar.add("item", {
	display = "active",
	position = "right",
	updates = true,
	label = { align = "center", padding_left = 3, padding_right = 6, font = { size = 17 }, y_offset = 1 },
	icon = { align = "center", padding_left = 3, padding_right = 0, font = { size = 17 }, y_offset = 1 },
})

local state = {
	kb_icon = kb_icons.unknown,
	kb_color = colors.white,
	svim_mode = nil,
	svim_cmdline = nil,
}

local function render()
	local icon = {
		string = state.kb_icon,
		color = colors.black,
		width = "dynamic",
	}

	local label = {
		string = state.kb_icon,
		color = colors.black,
		width = "dynamic",
	}

	local background = { color = colors.transparent }

	if state.svim_mode and svim_icons[state.svim_mode] then
		icon.string = svim_icons[state.svim_mode]
		background.color = svim_colors[state.svim_mode]

		if state.svim_mode == "C" and state.svim_cmdline then
			label.string = state.kb_icon .. " " .. svim_icons.C .. " " .. state.svim_cmdline
		end
	else
		icon.string = ""
		icon.width = 0
		label.color = state.kb_color
	end

	input:set({ icon = icon, label = label, background = background })
end

local function on_keyboard(ENV)
	local layout = helpers.safe_exec("im-select")

	state.kb_icon = kb_icons.unknown
	state.kb_color = colors.white

	if layout == "com.apple.keylayout.US" then
		state.kb_icon = kb_icons.en
	elseif layout == "com.apple.keylayout.Russian" then
		state.kb_icon = kb_icons.ru
	end

	render()
end

local function on_svim(ENV)
	if ENV.MODE and ENV.MODE ~= "" then
		state.svim_mode = ENV.MODE
		state.svim_cmdline = ENV.CMDLINE
	else
		state.svim_mode = nil
		state.svim_cmdline = nil
	end

	render()
end

input:subscribe({ "forced", "keyboard_layout_change" }, on_keyboard)
input:subscribe({ "svim_update", "window_focus" }, on_svim)

return input

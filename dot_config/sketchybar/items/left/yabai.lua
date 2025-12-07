local sbar = require("sketchybar")
local colors = require("config").colors

local icons = {
	stack = "􀏭",
	fullscreen_zoom = "􀏜",
	parent_zoom = "􀥃",
	float = "􀢌",
}

local yabai = sbar.add("item", {
	display = "active",
	icon = { width = 0 },
	position = "left",
})

local function get_window_prop(prop_name, window_query)
	window_query = window_query ~= nil and window_query or ""

	return assert(
		io.popen([[yabai -m query --windows --window ]] .. window_query .. [[ | jq '.["]] .. prop_name .. [["]']])
			:read("a")
			:gsub("%s+", "")
	)
end

local function update()
	local icon = {
		string = "",
		width = 0,
		color = colors.white,
	}

	local label = {
		string = "",
		width = 0,
		color = colors.white,
	}

	if get_window_prop("is-floating") == "true" then
		icon.string = icons.float
		icon.color = colors.red
	elseif get_window_prop("has-fullscreen-zoom") == "true" then
		icon.string = icons.fullscreen_zoom
		icon.color = colors.green
	elseif get_window_prop("has-parent-zoom") == "true" then
		icon.string = icons.parent_zoom
		icon.color = colors.blue
	else
		local stack_index = get_window_prop("stack-index")

		if tonumber(stack_index) > 0 then
			local stack_index_last = get_window_prop("stack-index", "stack.last")

			icon.string = icons.stack
			icon.color = colors.magenta
			label.string = "[" .. stack_index .. "/" .. stack_index_last .. "]"
			label.width = 40
		end
	end

	if icon.string ~= "" then
		icon.width = 30
	end

	yabai:set({ icon = icon, label = label })
end

yabai:subscribe("window_focus", update)

return yabai

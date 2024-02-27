local sbar = require("sketchybar")
local colors = require("config").colors

sbar.exec("(cd $CONFIG_DIR/helper && make && killall helper); $CONFIG_DIR/helper/helper cpu_update 10.0")

local cpu = sbar.add("item", {
	position = "right",
	label = { align = "center", string = "", width = 32 },
	icon = "􀫥",
})

local function update(ENV)
	local value = tonumber(ENV.INFO)
	local label = { string = value .. "%", color = colors.grey }

	if value == 0 then
		label.string = "􀍠"
	elseif value < 30 then
		label.color = colors.white
	elseif value < 50 then
		label.color = colors.yellow
	elseif value < 60 then
		label.color = colors.orange
	elseif value < 80 then
		label.color = colors.red
	end

	sbar.animate("sin", 10, function()
		cpu:set({ label = label })
	end)
end

cpu:subscribe({ "forced", "cpu_update" }, update)

return cpu

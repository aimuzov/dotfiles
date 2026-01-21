local sbar = require("sketchybar")

local icons = {
	Running = "􀞿",
	Stopped = "􀞾",
	Unknown = "􀧸",
	NeedsLogin = "􀺇",
}

local tailscale = sbar.add("item", {
	padding_right = 0,
	position = "right",
})

local function update()
	local cmd = "/usr/local/bin/tailscale status --json | jq -r '.BackendState'"
	local state = assert(io.popen(cmd):read("a"):gsub("%s+", ""))
	tailscale:set({ icon = icons[state] or icons["Unknown"] })
end

tailscale:subscribe({ "routine", "forced", "tailscale_status_update" }, update)

return tailscale

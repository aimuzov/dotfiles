local sbar = require("sketchybar")
local colors = require("config").colors
local tag = "nightly"

local nvim = sbar.add("item", {
	icon = {
		font = "sketchybar-app-font:Regular:14",
		string = ":neovim:",
	},

	label = { drawing = false },

	position = "right",
	update_freq = 60 * 60,
})

local function action()
	sbar.exec('wezterm start -- zsh -c "nvim_update ' .. tag .. '"')
end

local function update()
	-- stylua: ignore start
	local version_next_file = assert(io.popen([[gh api --method GET /repos/neovim/neovim/releases | jq -r 'map(select(.tag_name == "]]..tag..[["))[0] | .body | capture("```\n(?<version>NVIM(.*))\n```\n\n"; "m") | .version']]))
	local version_next_result = assert(version_next_file:read("a"))
	local version_current_file = assert(io.popen([[$(asdf where neovim ]]..tag..[[)/bin/nvim --version | sed -e '4d']]))
	local version_current_result = assert(version_current_file:read("a"))
	-- stylua: ignore end

	local icon = { color = colors.white }

	if version_next_result ~= version_current_result then
		icon.color = colors.orange
	end

	sbar.animate("sin", 10, function()
		nvim:set({ icon = icon })
	end)
end

nvim:subscribe({ "forced", "routine", "nvim_update", "update" }, update)
nvim:subscribe("mouse.clicked", action)

return nvim

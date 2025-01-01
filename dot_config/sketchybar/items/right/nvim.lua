local sbar = require("sketchybar")
local colors = require("config").colors

local nvim = sbar.add("item", {
	icon = {
		font = "sketchybar-app-font:Regular:14",
		string = ":neovim:",
	},

	label = { drawing = true },

	popup = {
		align = "right",
		background = {
			corner_radius = 9,
			border_width = 5,
			border_color = colors.blue,
			color = colors.black,
		},
	},

	position = "right",
	update_freq = 60 * 60,
})

local nvim_ver_current = sbar.add("item", {
	position = "popup." .. nvim.name,
	padding_left = 10,
	padding_right = 10,
})

local nvim_ver_next = sbar.add("item", {
	position = "popup." .. nvim.name,
	padding_left = 10,
	padding_right = 10,
})

nvim:subscribe("mouse.entered", function()
	sbar.animate("sin", 10, function()
		nvim:set({ popup = { drawing = true } })
	end)
end)

nvim:subscribe("mouse.exited", function()
	nvim:set({ popup = { drawing = false } })
end)

local function get_nvim_tag()
	local file = assert(io.popen([[mise tool neovim --active --cd ~]]))
	local result = assert(file:read("a"))

	return result
end

local function action()
	sbar.exec('wezterm start -- zsh -c "nvim_update ' .. get_nvim_tag() .. '"')
end

local function update()
	local tag = get_nvim_tag()
	-- stylua: ignore start
	local version_next_file = assert(io.popen([[$(mise where ubi:cli/cli latest)/bin/gh api --method GET /repos/neovim/neovim/releases | jq -r 'map(select(.tag_name == "]]..tag..[["))[0] | .body | capture("```\n(?<version>NVIM(.*))\n```\n\n"; "m") | .version']]))
	local version_next_result = assert(version_next_file:read("a"))
	local version_current_file = assert(io.popen([[$(mise where neovim ]]..tag..[[)/bin/nvim --version | sed -e '4d']]))
	local version_current_result = assert(version_current_file:read("a"))
	-- stylua: ignore end

	local icon = { color = colors.white }

	nvim_ver_current:set({ label = version_current_result:gsub("NVIM", "current: "):gsub("Build type.*", "") })
	nvim_ver_next:set({ label = version_next_result:gsub("NVIM", "next: "):gsub("Build type.*", "") })

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

local function bufferline_custom_groups()
	if package.loaded["bufferline"] == nil then
		return
	end

	local blg = require("bufferline.groups")

	blg.setup({
		options = {
			groups = blg.custom_groups_create({
				["docs"] = "%.md",
				["lua"] = "%.lua",
				["chezmoi"] = "chezmoi",
				["fish"] = "%.fish",
			}),
		},
	})
end

bufferline_custom_groups()

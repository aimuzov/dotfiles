local function override_keys_to_string()
	local Keys = require("lazy.core.handler.keys")
	local to_string_original = Keys.to_string

	Keys.to_string = function(keys)
		local result_raw = to_string_original(keys)
		local result_pretty = result_raw
			:gsub("<leader>", "󱁐")
			:gsub("%(v%)", "󰬝")
			:gsub("%(i%)", "󰬐")
			:gsub("%(x%)", "󰬟")
			:gsub("%(t%)", "󰬛")

		return result_pretty
	end
end

return {
	"LazyVim/LazyVim",
	opts = override_keys_to_string,
}

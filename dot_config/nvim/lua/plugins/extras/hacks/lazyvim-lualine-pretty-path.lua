local function override_lualine_pretty_path()
	local pretty_path_orig = LazyVim.lualine.pretty_path

	LazyVim.lualine.pretty_path = function(opts)
		local cb = pretty_path_orig(opts)

		return function(self)
			local result = cb(self)

			result = result:gsub("/", "󰿟"):gsub("…", "󰇘")

			return result
		end
	end
end

return {
	"LazyVim/LazyVim",
	opts = override_lualine_pretty_path,
}

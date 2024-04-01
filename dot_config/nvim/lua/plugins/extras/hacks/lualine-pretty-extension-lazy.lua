return {
	"nvim-lualine/lualine.nvim",
	optional = true,

	opts = function()
		require("lualine.extensions.lazy").sections.lualine_a = {
			function()
				return "󰰍 lazy "
			end,
		}
	end,
}

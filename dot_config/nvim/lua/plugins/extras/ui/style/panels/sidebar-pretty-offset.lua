return {
	"folke/edgy.nvim",
	optional = true,

	dependencies = {
		{
			"akinsho/bufferline.nvim",
			optional = true,

			opts = function()
				local Offset = require("bufferline.offset")

				if Offset.edgy then
					Offset.get = function()
						local layout = require("edgy.config").layout
						local width_left = (layout.left ~= nil and #layout.left.wins > 0) and layout.left.bounds.width
							or 0
						local width_right = (layout.right ~= nil and #layout.right.wins > 0)
								and layout.right.bounds.width
							or 0

						local ret = {
							left = "%#EdgyTitle#" .. string.rep(" ", width_left) .. "%*",
							right = "%#EdgyTitle#" .. string.rep(" ", width_right) .. "%*",
							left_size = width_left,
							right_size = width_right,
							total_size = width_left + width_right,
						}

						return ret
					end
				end
			end,
		},
	},
}

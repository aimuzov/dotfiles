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
						local left_width = #layout.left.wins > 0 and layout.left.bounds.width or 0
						local right_width = #layout.right.wins > 0 and layout.right.bounds.width or 0

						local ret = {
							left = "%#EdgyTitle#" .. string.rep(" ", left_width) .. "%*",
							right = "%#EdgyTitle#" .. string.rep(" ", right_width) .. "%*",
							left_size = left_width,
							right_size = right_width,
							total_size = left_width + right_width,
						}

						return ret
					end
				end
			end,
		},
	},
}

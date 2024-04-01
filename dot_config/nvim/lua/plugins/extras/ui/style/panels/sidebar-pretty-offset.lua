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
					local get = Offset.get

					Offset.get = function()
						local ret = get()

						ret.left = ret.left:gsub("WinSeparator", "EdgyWinSeparator")
						ret.right = ret.right:gsub("WinSeparator", "EdgyWinSeparator")

						return ret
					end
				end
			end,
		},
	},
}

local color_blend = require("util").color_blend

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,

		opts = {
			integrations = {
				navic = false,
				treesitter_context = true,
				dap = { enabled = true, enable_ui = true },
			},
			highlight_overrides = {
				all = function(c)
					return {
						AerialLine = { fg = "none", bg = c.crust },
						AlphaHeader1 = { fg = c.surface2 },
						AlphaHeader2 = { fg = color_blend(c.base, c.blue, 5) },
						AlphaHeader3 = { fg = color_blend(c.base, c.sky, 5) },
						AlphaHeader4 = { fg = color_blend(c.base, c.green, 5) },
						AlphaHeader5 = { fg = color_blend(c.base, c.yellow, 5) },
						AlphaHeader6 = { fg = color_blend(c.base, c.peach, 5) },
						AlphaHeader7 = { fg = color_blend(c.base, c.red, 5) },
						AlphaHeader8 = { fg = c.surface2 },
						AlphaFooter = { fg = c.surface1, style = {} },
						AlphaShortcutBorder = { fg = color_blend(c.base, c.surface1, 50) },
						-- stylua: ignore
						AlphaShortcut = { bg = color_blend(c.base, c.mantle, 50), fg = color_blend(c.base, c.surface1, 50) },
						BufferLineFill = { bg = c.mantle },
						BufferLineIndicatorVisible = { bg = c.mantle },
						BufferLineModifiedVisible = { bg = c.mantle, fg = c.surface0 },
						BufferLinePick = { bg = c.mantle },
						BufferLinePickVisible = { bg = c.mantle },
						BufferLineBufferSelected = { style = { "bold" } },
						BufferLineTabSelected = { fg = c.text, style = { "bold" } },
						BufferLineTabSeparator = { bg = c.mantle, fg = c.mantle },
						BufferLineTabSeparatorSelected = { fg = c.base, style = { "bold" } },
						BufferLineTruncMarker = { bg = c.mantle, fg = c.surface1, style = { "bold" } },
						ChatGPTQuestion = { fg = c.mauve },
						ChatGPTTotalTokens = { bg = "none", fg = c.overlay2 },
						ChatGPTTotalTokensBorder = { fg = c.text },
						CmpDocFloat = { bg = c.mantle, blend = 15 },
						DiffviewDiffAdd = { bg = color_blend(c.green, c.base, 93) },
						DiffviewDiffDelete = { bg = color_blend(c.red, c.base, 93) },
						DiffviewNormal = { bg = c.mantle },
						DiffviewWinSeparator = { link = "NeoTreeWinSeparator" },
						EdgyNormal = { bg = c.base },
						EdgyTitle = { bg = c.mantle },
						FlashPrompt = { bg = c.mantle },
						Folded = { bg = c.base, fg = c.surface2 },
						GitConflictCurrent = { bg = color_blend(c.blue, c.base, 90) },
						GitConflictCurrentLabel = { bg = color_blend(c.blue, c.base, 85) },
						GitConflictIncoming = { bg = color_blend(c.green, c.base, 90) },
						GitConflictIncomingLabel = { bg = color_blend(c.green, c.base, 85) },
						GitSignsAdd = { fg = color_blend(c.green, c.base, 50) },
						GitSignsAddInline = { bg = color_blend(c.green, c.base, 83) },
						GitSignsAddPreview = { bg = color_blend(c.green, c.base, 93) },
						GitSignsChange = { fg = color_blend(c.yellow, c.base, 50) },
						GitSignsDelete = { fg = color_blend(c.red, c.base, 50) },
						GitSignsDeleteInline = { bg = color_blend(c.red, c.base, 83) },
						GitSignsDeletePreview = { bg = color_blend(c.red, c.base, 93) },
						LazyReasonKeys = { fg = c.overlay0 },
						NeoTreeCursorLine = { bg = c.crust },
						NeoTreeDotfile = { fg = c.overlay0 },
						NeoTreeFadeText1 = { fg = c.surface1 },
						NeoTreeFadeText2 = { fg = c.surface2 },
						NeoTreeFileStats = { fg = c.surface1 },
						NeoTreeFileStatsHeader = { fg = c.surface2 },
						NeoTreeFloatBorder = { bg = c.base, fg = c.lavender },
						NeoTreeFloatNormal = { bg = c.base },
						NeoTreeFloatTitle = { bg = c.base, fg = c.sky },
						NeoTreeMessage = { fg = c.surface1 },
						NeoTreeModified = { fg = c.peach },
						NeoTreeRootName = { fg = c.green },
						NeoTreeTabActive = { fg = c.text, bg = color_blend(c.base, c.text, 10) },
						NeoTreeTabSeparatorActive = { bg = c.base, fg = c.base },
						NeoTreeWinSeparator = { bg = c.base, fg = c.base },
						NoiceCmdline = { bg = c.mantle },
						NoiceFormatEvent = { fg = c.overlay1 },
						NoiceFormatKind = { fg = c.overlay0 },
						NoiceLspProgressTitle = { fg = c.overlay0 },
						NoicePopup = { bg = c.mantle },
						NonText = { fg = c.base },
						NormalFloat = { bg = c.base },
						TreesitterContext = { bg = c.base, blend = 0 },
						TreesitterContextBottom = { fg = c.surface2, blend = 0, style = { "underline" } },
						TreesitterContextLineNumber = { bg = c.base or c.base },
						TroubleCount = { bg = "none" },
						TroubleNormal = { bg = c.base },
						WinSeparator = { fg = color_blend(c.base, c.crust, 40) },
						Visual = { style = {} },
						WhichKeyFloat = { bg = c.mantle },
						Whitespace = { fg = c.base },
						ZenBg = { bg = c.mantle },
					}
				end,

				frappe = function(c)
					return {
						AerialGuide = { fg = c.surface0 },
						GitSignsCurrentLineBlame = { fg = c.surface2 },
						IblIndent = { fg = c.surface0 },
						IblScope = { fg = c.surface2 },
						IlluminatedWordRead = { bg = c.surface0 },
						IlluminatedWordText = { bg = c.surface1 },
						IlluminatedWordWrite = { bg = c.surface1 },
						NeoTreeIndentMarker = { fg = c.base },
						SatelliteBar = { bg = c.surface0, blend = 15 },
						SpectreBorderCustom = { fg = c.surface0 },
						SymbolUsageText = { fg = c.surface2 },
						Visual = { bg = color_blend(c.base, c.surface2, 35) },
					}
				end,

				latte = function(c)
					return {
						AerialGuide = { fg = c.crust },
						GitSignsCurrentLineBlame = { fg = c.surface0 },
						IblIndent = { fg = c.crust },
						IblScope = { fg = c.surface1 },
						IlluminatedWordRead = { bg = c.mantle },
						IlluminatedWordText = { bg = c.surface0 },
						IlluminatedWordWrite = { bg = c.surface0 },
						NeoTreeIndentMarker = { fg = c.surface0 },
						SatelliteBar = { bg = c.crust, blend = 15 },
						SpectreBorderCustom = { fg = c.crust },
						SymbolUsageText = { fg = c.surface0 },
						Visual = { bg = color_blend(c.base, c.crust, 60) },
					}
				end,
			},
		},
	},
}

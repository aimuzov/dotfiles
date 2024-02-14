local util_other = require("util.other")

local function set_hl(name, value)
	vim.api.nvim_set_hl(0, name, value)
end

local highlights_override_start_logo_cmd = function(i, color)
	set_hl("StartLogo" .. i, { fg = color })
end

local highlights_override_start_logo_pre = function(colors)
	local c = util_other.get_palette().palette

	for i = 2, 7 do
		highlights_override_start_logo_cmd(i, util_other.blend_color(c.base, colors[i - 1], 5))
	end

	highlights_override_start_logo_cmd(1, c.surface2)
	highlights_override_start_logo_cmd(8, c.surface2)
end

local highlights_override_start_logo_anim = function()
	local c = util_other.get_palette().palette

	local colors = {
		c.blue,
		c.sky,
		c.green,
		c.yellow,
		c.peach,
		c.red,
	}

	highlights_override_start_logo_pre(colors)

	local limit = c.is_dark and 100 or 30

	for i = 5, limit do
		local timer = vim.loop.new_timer()

		timer:start(
			i * 30,
			0,
			vim.schedule_wrap(function()
				for j = 2, 7 do
					highlights_override_start_logo_cmd(j, util_other.blend_color(c.base, colors[j - 1], i))
				end
			end)
		)
	end
end

local highlights_override_lualine = function()
	local c = util_other.get_palette().palette

	local colors = {
		["normal"] = c.blue,
		["insert"] = c.green,
		["visual"] = c.mauve,
		["replace"] = c.red,
		["command"] = c.peach,
		["terminal"] = c.green,
		["inactive"] = c.mantle,
	}

	for mode, color in pairs(colors) do
		set_hl("lualine_a_" .. mode, { bg = util_other.blend_color(c.mantle, color, 80), fg = c.base })
		set_hl("lualine_b_" .. mode, {
			bg = util_other.is_os_theme_dark() and util_other.blend_color(c.base, color, 15)
				or util_other.blend_color(c.crust, color, 5),
			fg = color,
		})
	end
end

local highlights_override = function()
	local c = util_other.get_palette().palette

	set_hl("AerialGuide", { fg = c.is_dark and c.surface0 or c.crust })
	set_hl("AerialLine", { fg = "none", bg = c.crust })
	set_hl("BufferLineFill", { bg = c.mantle })
	set_hl("BufferLinePick", { bg = c.mantle })
	set_hl("BufferLinePickVisible", { bg = c.mantle })
	set_hl("BufferLineIndicatorVisible", { bg = c.mantle })
	set_hl("BufferLineModifiedVisible", { fg = c.surface0, bg = c.mantle })
	set_hl("BufferLineTabSelected", { fg = c.text, bold = true })
	set_hl("BufferLineTabSeparator", { fg = c.mantle })
	set_hl("BufferLineTabSeparatorSelected", { fg = c.base, bold = true })
	set_hl("BufferLineTruncMarker", { bg = c.mantle })
	set_hl("ChatGPTQuestion", { fg = c.mauve })
	set_hl("ChatGPTTotalTokens", { fg = c.overlay2, bg = "none" })
	set_hl("ChatGPTTotalTokensBorder", { fg = c.text })
	set_hl("CmpDocFloat", { blend = 15, bg = c.mantle })
	set_hl("DiffviewDiffAdd", { bg = util_other.blend_color(c.green, c.base, 93) })
	set_hl("DiffviewDiffDelete", { bg = util_other.blend_color(c.red, c.base, 93) })
	set_hl("DiffviewNormal", { bg = c.mantle })
	set_hl("DiffviewWinSeparator", { link = "NeoTreeWinSeparator" })
	set_hl("EdgyNormal", { bg = c.base })
	set_hl("EdgyTitle", { bg = c.mantle })
	set_hl("FlashPrompt", { bg = c.mantle })
	set_hl("Folded", { fg = c.surface2, bg = c.base })
	set_hl("GitConflictCurrent", { bg = util_other.blend_color(c.blue, c.base, 90) })
	set_hl("GitConflictCurrentLabel", { bg = util_other.blend_color(c.blue, c.base, 85) })
	set_hl("GitConflictIncoming", { bg = util_other.blend_color(c.green, c.base, 90) })
	set_hl("GitConflictIncomingLabel", { bg = util_other.blend_color(c.green, c.base, 85) })
	set_hl("GitSignsAdd", { fg = util_other.blend_color(c.green, c.base, 50) })
	set_hl("GitSignsAddInline", { bg = util_other.blend_color(c.green, c.base, 83) })
	set_hl("GitSignsAddPreview", { bg = util_other.blend_color(c.green, c.base, 93) })
	set_hl("GitSignsChange", { fg = util_other.blend_color(c.yellow, c.base, 50) })
	set_hl("GitSignsCurrentLineBlame", { fg = c.is_dark and c.surface2 or c.surface0 })
	set_hl("GitSignsDelete", { fg = util_other.blend_color(c.red, c.base, 50) })
	set_hl("GitSignsDeleteInline", { bg = util_other.blend_color(c.red, c.base, 83) })
	set_hl("GitSignsDeletePreview", { bg = util_other.blend_color(c.red, c.base, 93) })
	set_hl("IlluminatedWordRead", { bg = c.is_dark and c.surface0 or c.mantle })
	set_hl("IlluminatedWordText", { bg = c.is_dark and c.surface1 or c.surface0 })
	set_hl("IlluminatedWordWrite", { bg = c.is_dark and c.surface1 or c.surface0 })
	set_hl("LazyReasonKeys", { fg = c.overlay0 })
	set_hl("NeoTreeCursorLine", { bg = c.crust })
	set_hl("NeoTreeFloatBorder", { bg = c.base, fg = c.lavender })
	set_hl("NeoTreeFloatNormal", { bg = c.base })
	set_hl("NeoTreeFileStats", { fg = c.surface1 })
	set_hl("NeoTreeFileStatsHeader", { fg = c.surface2 })
	set_hl("NeoTreeMessage", { fg = c.surface1 })
	set_hl("NeoTreeModified", { fg = c.peach })
	set_hl("NeoTreeDotfile", { fg = c.overlay0 })
	set_hl("NeoTreeFadeText1", { fg = c.surface1 })
	set_hl("NeoTreeFadeText2", { fg = c.surface2 })
	set_hl("NeoTreeFloatTitle", { bg = c.base })
	set_hl("NeoTreeFloatTitle", { fg = c.sky })
	set_hl("NeoTreeIndentMarker", { fg = c.is_dark and c.base or c.surface0 })
	set_hl("NeoTreeRootName", { fg = c.green })
	-- stylua: ignore
	set_hl("NeoTreeTabActive", { fg = c.text, bg = util_other.blend_color(c.base, c.text, 10) })
	set_hl("NeoTreeTabSeparatorActive", { fg = c.base, bg = c.base })
	set_hl("NeoTreeWinSeparator", { bg = c.base, fg = c.base, force = true })
	set_hl("NoiceCmdline", { bg = c.mantle })
	set_hl("NoiceFormatEvent", { fg = c.overlay1 })
	set_hl("NoiceFormatKind", { fg = c.overlay0 })
	set_hl("NoiceLspProgressTitle", { fg = c.overlay0 })
	set_hl("NoicePopup", { bg = c.mantle })
	set_hl("NonText", { fg = c.base })
	set_hl("NormalFloat", { bg = c.base })
	set_hl("SpectreBorderCustom", { fg = c.is_dark and c.surface0 or c.crust })
	set_hl("SatelliteBar", { blend = 15, bg = c.is_dark and c.surface0 or c.crust })
	set_hl("SymbolUsageText", { fg = c.is_dark and c.surface2 or c.surface0 })
	set_hl("TreesitterContext", { bg = c.base, blend = 0 })
	set_hl("TreesitterContextBottom", { underline = true, fg = c.surface2, blend = 0 })
	set_hl("TreesitterContextLineNumber", { bg = c.base or c.base })
	set_hl("TroubleCount", { bg = "none" })
	set_hl("TroubleNormal", { bg = c.base })
	set_hl("VertSplit", { fg = c.mantle })
	-- stylua: ignore
	set_hl("Visual", { bg = c.is_dark and c.surface1 or util_other.blend_color(c.base, c.crust, 60), bold = false, })
	set_hl("WhichKeyFloat", { bg = c.mantle })
	set_hl("Whitespace", { fg = c.base })
	set_hl("ZenBg", { bg = c.mantle })

	highlights_override_start_logo_anim()
	highlights_override_lualine()
end

local highlights_override_hack = function()
	local c = util_other.get_palette().palette

	set_hl("AlphaFooter", { fg = c.surface1, italic = false })
	set_hl("AlphaShortcutBorder", { fg = util_other.blend_color(c.base, c.surface1, 50) })
	set_hl("AlphaShortcut", {
		fg = util_other.blend_color(c.base, c.surface1, 50),
		bg = util_other.blend_color(c.base, c.mantle, 50),
	})

	set_hl("IblIndent", { fg = c.is_dark and c.surface0 or c.crust })
	set_hl("IblScope", { fg = c.is_dark and c.surface2 or c.surface1 })
end

return {
	highlights_override = highlights_override,
	highlights_override_hack = highlights_override_hack,
	highlights_override_start_logo_anim = highlights_override_start_logo_anim,
}

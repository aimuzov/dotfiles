local util_other = require("util.other")

local function update_hl(group, value)
	local is_ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = group, create = true })

	if hl_def[true] or not is_ok then
		hl_def = value
	end

	if is_ok then
		for k, v in pairs(value) do
			hl_def[k] = v
		end
	end

	vim.api.nvim_set_hl(0, group, hl_def)
end

local highlights_override_start_logo_cmd = function(i, color)
	update_hl("StartLogo" .. i, { fg = color })
end

local highlights_override_start_logo_pre = function(colors)
	local c = util_other.get_palette()

	for i = 2, 7 do
		highlights_override_start_logo_cmd(i, util_other.blend_color(c.palette.base, colors[i - 1], 5))
	end

	highlights_override_start_logo_cmd(1, c.palette.surface2)
	highlights_override_start_logo_cmd(8, c.palette.surface2)
end

local highlights_override_start_logo_anim = function()
	local c = util_other.get_palette()

	local colors = {
		c.palette.blue,
		c.palette.sky,
		c.palette.green,
		c.palette.yellow,
		c.palette.peach,
		c.palette.red,
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
					highlights_override_start_logo_cmd(j, util_other.blend_color(c.palette.base, colors[j - 1], i))
				end
			end)
		)
	end
end

local highlights_override_lualine = function()
	local c = util_other.get_palette()
	local modes = { "normal", "insert", "visual", "replace", "command", "terminal", "inactive" }

	for _, name in pairs(modes) do
		update_hl("lualine_b_" .. name, { bg = c.palette.mantle })
		update_hl("lualine_y_" .. name, { bg = c.palette.mantle })
	end
end

local highlights_override = function()
	local c = util_other.get_palette()

	update_hl("AerialGuide", { fg = c.is_dark and c.palette.surface0 or c.palette.crust })
	update_hl("AerialLine", { fg = "none", bg = c.palette.crust })
	update_hl("BufferLineBufferVisible", { fg = c.palette.text, bold = true })
	update_hl("BufferLineFill", { bg = c.palette.mantle })
	update_hl("BufferLinePick", { bg = c.palette.mantle })
	update_hl("BufferLinePickVisible", { bg = c.palette.mantle })
	update_hl("BufferLineIndicatorVisible", { bg = c.palette.mantle })
	update_hl("BufferLineModifiedVisible", { fg = c.palette.surface0, bg = c.palette.mantle })
	update_hl("BufferLineTabSelected", { fg = c.palette.text, bold = true })
	update_hl("BufferLineTabSeparator", { fg = c.palette.mantle })
	update_hl("BufferLineTabSeparatorSelected", { fg = c.palette.base, bold = true })
	update_hl("BufferLineTruncMarker", { bg = c.palette.mantle })
	update_hl("ChatGPTQuestion", { fg = c.palette.mauve })
	update_hl("ChatGPTTotalTokens", { fg = c.palette.overlay2, bg = "none" })
	update_hl("ChatGPTTotalTokensBorder", { fg = c.palette.text })
	update_hl("CmpDocFloat", { blend = 15, bg = c.palette.mantle })
	update_hl("DiffviewDiffAdd", { bg = util_other.blend_color(c.palette.green, c.palette.base, 93) })
	update_hl("DiffviewDiffDelete", { bg = util_other.blend_color(c.palette.red, c.palette.base, 93) })
	update_hl("DiffviewNormal", { bg = c.palette.mantle })
	update_hl("DiffviewWinSeparator", { link = "NeoTreeWinSeparator" })
	update_hl("EdgyNormal", { bg = c.palette.base })
	update_hl("EdgyTitle", { bg = c.palette.mantle })
	update_hl("FlashPrompt", { bg = c.palette.mantle })
	update_hl("Folded", { fg = c.palette.surface2, bg = c.palette.base })
	update_hl("GitConflictCurrent", { bg = util_other.blend_color(c.palette.blue, c.palette.base, 90) })
	update_hl("GitConflictCurrentLabel", { bg = util_other.blend_color(c.palette.blue, c.palette.base, 85) })
	update_hl("GitConflictIncoming", { bg = util_other.blend_color(c.palette.green, c.palette.base, 90) })
	update_hl("GitConflictIncomingLabel", { bg = util_other.blend_color(c.palette.green, c.palette.base, 85) })
	update_hl("GitSignsAdd", { fg = util_other.blend_color(c.palette.green, c.palette.base, 50) })
	update_hl("GitSignsAddInline", { bg = util_other.blend_color(c.palette.green, c.palette.base, 83) })
	update_hl("GitSignsAddPreview", { bg = util_other.blend_color(c.palette.green, c.palette.base, 93) })
	update_hl("GitSignsChange", { fg = util_other.blend_color(c.palette.yellow, c.palette.base, 50) })
	update_hl("GitSignsCurrentLineBlame", { fg = c.is_dark and c.palette.surface2 or c.palette.surface0 })
	update_hl("GitSignsDelete", { fg = util_other.blend_color(c.palette.red, c.palette.base, 50) })
	update_hl("GitSignsDeleteInline", { bg = util_other.blend_color(c.palette.red, c.palette.base, 83) })
	update_hl("GitSignsDeletePreview", { bg = util_other.blend_color(c.palette.red, c.palette.base, 93) })
	update_hl("IlluminatedWordRead", { bg = c.is_dark and c.palette.surface0 or c.palette.mantle })
	update_hl("IlluminatedWordText", { bg = c.is_dark and c.palette.surface1 or c.palette.surface0 })
	update_hl("IlluminatedWordWrite", { bg = c.is_dark and c.palette.surface1 or c.palette.surface0 })
	update_hl("LazyReasonKeys", { fg = c.palette.overlay0 })
	update_hl("NeoTreeCursorLine", { bg = c.palette.crust })
	update_hl("NeoTreeFloatBorder", { bg = c.palette.base, fg = c.palette.lavender })
	update_hl("NeoTreeFloatNormal", { bg = c.palette.base })
	update_hl("NeoTreeFileStats", { fg = c.palette.surface1 })
	update_hl("NeoTreeFileStatsHeader", { fg = c.palette.surface2 })
	update_hl("NeoTreeMessage", { fg = c.palette.surface1 })
	update_hl("NeoTreeModified", { fg = c.palette.peach })
	update_hl("NeoTreeDotfile", { fg = c.palette.overlay0 })
	update_hl("NeoTreeFadeText1", { fg = c.palette.surface1 })
	update_hl("NeoTreeFadeText2", { fg = c.palette.surface2 })
	update_hl("NeoTreeFloatTitle", { bg = c.palette.base })
	update_hl("NeoTreeFloatTitle", { fg = c.palette.sky })
	update_hl("NeoTreeIndentMarker", { fg = c.is_dark and c.palette.base or c.palette.surface0 })
	update_hl("NeoTreeRootName", { fg = c.palette.green })
	-- stylua: ignore
	update_hl("NeoTreeTabActive", { fg = c.palette.text, bg = util_other.blend_color(c.palette.base, c.palette.text, 10) })
	update_hl("NeoTreeTabSeparatorActive", { fg = c.palette.base, bg = c.palette.base })
	update_hl("NeoTreeWinSeparator", { bg = c.palette.base, fg = c.palette.base })
	update_hl("NoiceCmdline", { bg = c.palette.mantle })
	update_hl("NoiceFormatEvent", { fg = c.palette.overlay1 })
	update_hl("NoiceFormatKind", { fg = c.palette.overlay0 })
	update_hl("NoiceLspProgressTitle", { fg = c.palette.overlay0 })
	update_hl("NoicePopup", { bg = c.palette.mantle })
	update_hl("NonText", { fg = c.palette.base })
	update_hl("NormalFloat", { bg = c.palette.base })
	update_hl("SpectreBorderCustom", { fg = c.is_dark and c.palette.surface0 or c.palette.crust })
	update_hl("SatelliteBar", { blend = 15, bg = c.is_dark and c.palette.surface0 or c.palette.crust })
	update_hl("SymbolUsageText", { fg = c.is_dark and c.palette.surface2 or c.palette.surface0 })
	update_hl("TreesitterContext", { bg = c.palette.base, blend = 0 })
	update_hl("TreesitterContextBottom", { fg = c.palette.surface2, blend = 0 })
	update_hl("TreesitterContextLineNumber", { bg = c.palette.base or c.palette.base })
	update_hl("TroubleCount", { bg = "none" })
	update_hl("TroubleNormal", { bg = c.palette.base })
	update_hl("VertSplit", { fg = c.palette.mantle })
	-- stylua: ignore
	update_hl("Visual", { bg = c.is_dark and c.palette.surface1 or util_other.blend_color(c.palette.base, c.palette.crust, 60), bold = false, })
	update_hl("WhichKeyFloat", { bg = c.palette.mantle })
	update_hl("Whitespace", { fg = c.palette.base })
	update_hl("ZenBg", { bg = c.palette.mantle })

	highlights_override_start_logo_anim()
	highlights_override_lualine()
end

local highlights_override_hack = function()
	local c = util_other.get_palette()

	update_hl("AlphaFooter", { fg = c.palette.surface1, italic = false })
	update_hl("AlphaShortcutBorder", { fg = util_other.blend_color(c.palette.base, c.palette.surface1, 50) })
	update_hl("AlphaShortcut", {
		fg = util_other.blend_color(c.palette.base, c.palette.surface1, 50),
		bg = util_other.blend_color(c.palette.base, c.palette.mantle, 50),
	})

	update_hl("IblIndent", { fg = c.is_dark and c.palette.surface0 or c.palette.crust })
	update_hl("IblScope", { fg = c.is_dark and c.palette.surface2 or c.palette.surface1 })
end

return {
	highlights_override = highlights_override,
	highlights_override_hack = highlights_override_hack,
	highlights_override_start_logo_anim = highlights_override_start_logo_anim,
}

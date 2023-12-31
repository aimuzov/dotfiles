local convert_dec2hex = function(n_value)
	if type(n_value) == "string" then
		n_value = tonumber(n_value)
	end
	local n_hex_val = string.format("%X", n_value) -- %X returns uppercase hex, %x gives lowercase letters
	local s_hex_val = n_hex_val .. ""

	if n_value < 16 then
		return "0" .. tostring(s_hex_val)
	else
		return s_hex_val
	end
end

local blend_color = function(colour1, colour2, percentage)
	local r1, g1, b1 = string.upper(colour1):match("#([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])")
	local r2, g2, b2 = string.upper(colour2):match("#([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])")
	local r3 = tonumber(r1, 16) * (100 - percentage) / 100.0 + tonumber(r2, 16) * percentage / 100.0
	local g3 = tonumber(g1, 16) * (100 - percentage) / 100.0 + tonumber(g2, 16) * percentage / 100.0
	local b3 = tonumber(b1, 16) * (100 - percentage) / 100.0 + tonumber(b2, 16) * percentage / 100.0
	return "#" .. convert_dec2hex(r3) .. convert_dec2hex(g3) .. convert_dec2hex(b3)
end

local get_palette = function()
	local palette = require("catppuccin.palettes").get_palette()
	local is_dark = vim.g.colors_name == "catppuccin-frappe"

	return { palette = palette, is_dark = is_dark }
end

local is_os_theme_dark = function()
	local handle = io.popen("defaults read -g AppleInterfaceStyle 2>&1", "r")
	local result_raw = handle ~= nil and handle:read("*a")
	local result_safety = result_raw:gsub("[\n\r]", "")
	local is_dark = result_safety == "Dark"

	if handle ~= nil then
		handle:close()
	end

	return is_dark
end

local get_colorscheme = function()
	local colorscheme = is_os_theme_dark() and "catppuccin-frappe" or "catppuccin-latte"
	return colorscheme
end

local lazygit_open = function()
	local lazy_util = require("lazyvim.util")
	local theme = is_os_theme_dark() and "dark" or "light"
	local cfg_dir = vim.fn.getenv("HOME") .. "/.config/lazygit"

	lazy_util.terminal.open({ "lazygit" }, {
		cwd = lazy_util.root.get(),
		border = "none",
		env = { ["LG_CONFIG_FILE"] = cfg_dir .. "/config.yml," .. cfg_dir .. "/theme-" .. theme .. ".yml" },
		zindex = 60,
		size = { height = 1, width = 1 },
		esc_esc = false,
		margin = { top = 1, bottom = 1 },
		ctrl_hjkl = false,
	})
end

local remove_substring = function(str, substr)
	local startIndex, endIndex = string.find(str, substr)

	if startIndex and endIndex then
		local prefix = string.sub(str, 1, startIndex - 1)
		local suffix = string.sub(str, endIndex + 1)
		return prefix .. suffix
	end

	return str
end

return {
	blend_color = blend_color,
	get_palette = get_palette,
	is_os_theme_dark = is_os_theme_dark,
	get_colorscheme = get_colorscheme,
	lazygit_open = lazygit_open,
	remove_substring = remove_substring,
}

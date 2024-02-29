local M = {}

local function color_convert_dec2hex(n_value)
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

function M.color_blend(color_first, color_second, percentage)
	local r1, g1, b1 = string.upper(color_first):match("#([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])")
	local r2, g2, b2 = string.upper(color_second):match("#([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])")

	local r3 = tonumber(r1, 16) * (100 - percentage) / 100.0 + tonumber(r2, 16) * percentage / 100.0
	local g3 = tonumber(g1, 16) * (100 - percentage) / 100.0 + tonumber(g2, 16) * percentage / 100.0
	local b3 = tonumber(b1, 16) * (100 - percentage) / 100.0 + tonumber(b2, 16) * percentage / 100.0

	return "#" .. color_convert_dec2hex(r3) .. color_convert_dec2hex(g3) .. color_convert_dec2hex(b3)
end

function M.os_theme_is_dark()
	local cmd_handle = io.popen("defaults read -g AppleInterfaceStyle 2>&1", "r")
	local cmd_result_raw = cmd_handle ~= nil and cmd_handle:read("*a")
	local cmd_result_safety = cmd_result_raw:gsub("[\n\r]", "")
	local os_theme_is_dark = cmd_result_safety == "Dark"

	if cmd_handle ~= nil then
		cmd_handle:close()
	end

	return os_theme_is_dark
end

function M.colorscheme_get_name()
	return M.os_theme_is_dark() and "catppuccin-frappe" or "catppuccin-latte"
end

function M.colorscheme_change()
	vim.cmd.colorscheme(M.colorscheme_get_name())
end

function M.colors_get(flavor)
	return require("catppuccin.palettes").get_palette(flavor)
end

function M.lualine_theme_create()
	local c = M.colors_get()

	local colors = {
		["normal"] = c.blue,
		["insert"] = c.green,
		["visual"] = c.mauve,
		["replace"] = c.red,
		["command"] = c.peach,
		["terminal"] = c.green,
		["inactive"] = c.mantle,
	}

	local theme = {}

	for mode, color in pairs(colors) do
		theme[mode] = {
			a = { bg = M.color_blend(c.mantle, color, 70), fg = c.mantle },
			b = { bg = M.color_blend(c.mantle, color, 15), fg = color },
			c = { bg = M.color_blend(c.base, c.mantle, 50), fg = mode == "inactive" and c.surface2 or c.text },
		}
	end

	return theme
end

function M.alpha_header_animate()
	local c = M.colors_get()
	local colors = { c.blue, c.sky, c.green, c.yellow, c.peach, c.red }
	local limit = M.os_theme_is_dark() and 100 or 20

	for i = 5, limit do
		vim.schedule(function()
			local timer = vim.loop.new_timer()

			timer:start(
				i * 30,
				0,
				vim.schedule_wrap(function()
					for j = 2, 7 do
						vim.api.nvim_set_hl(0, "AlphaHeader" .. j, { fg = M.color_blend(c.base, colors[j - 1], i) })
					end
				end)
			)
		end)
	end
end

return M

local wezterm = require("wezterm")

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}

	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)

		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)

				number_value = number_value - 1
			end

			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)

			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end

	window:set_config_overrides(overrides)
end)

local scheme_by_os = function(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Frappe Extended"
	else
		return "Catppuccin Latte Extended"
	end
end

local scheme_extend = function(scheme_name)
	local scheme = wezterm.color.get_builtin_schemes()[scheme_name]

	scheme.background = scheme.tab_bar.inactive_tab.bg_color
	scheme.tab_bar.active_tab.bg_color = scheme.tab_bar.background
	scheme.tab_bar.active_tab.fg_color = scheme.tab_bar.inactive_tab.fg_color
	scheme.tab_bar.inactive_tab.bg_color = scheme.tab_bar.background
	scheme.tab_bar.inactive_tab.fg_color = scheme.tab_bar.new_tab_hover.bg_color
	scheme.tab_bar.inactive_tab_hover.bg_color = scheme.indexed[16]
	scheme.tab_bar.inactive_tab_hover.fg_color = scheme.tab_bar.background

	return scheme
end

return {
	color_scheme = scheme_by_os(wezterm.gui.get_appearance()),
	color_schemes = {
		["Catppuccin Frappe Extended"] = scheme_extend("Catppuccin Frappe"),
		["Catppuccin Latte Extended"] = scheme_extend("Catppuccin Latte"),
	},

	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono NFM", weight = "Medium" },
		"Noto Emoji",
	}),

	adjust_window_size_when_changing_font_size = false,
	line_height = 1.3,
	font_size = 14,

	show_new_tab_button_in_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,

	cursor_blink_rate = 0,
	default_cursor_style = "SteadyBar",

	window_decorations = "RESIZE",
	window_padding = { left = 0, right = 0, top = "0.25cell", bottom = 0 },

	debug_key_events = false,
	use_ime = true,

	keys = {
		{ key = "р", mods = "CTRL", action = wezterm.action.SendString("\x08") },
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
		{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.DisableDefaultAssignment },
	},

	-- https://github.com/wez/wezterm/issues/119#issuecomment-1206593847
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = wezterm.action.CompleteSelection("PrimarySelection"),
		},

		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},

		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.Nop,
		},
	},
}

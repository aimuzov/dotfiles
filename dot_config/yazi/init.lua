local flavor = os.getenv("MACOS_IS_DARK") == "yes" and "macchiato" or "latte"
local catppuccin_theme = require("yatline-catppuccin"):setup(flavor)

th.mgr.border_style.fg = os.getenv("MACOS_IS_DARK") == "yes" and "#32324d" or "#dfe3ec"

catppuccin_theme.section_separator = { open = "", close = "" }
catppuccin_theme.part_separator = { open = "", close = "" }

local yatline_config = {
	theme = catppuccin_theme,
	show_background = true,

	header_line = {
		left = {
			section_a = {},
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {},
			section_b = {},
			section_c = {},
		},
	},

	status_line = {
		left = {
			section_a = { { type = "string", custom = false, name = "tab_mode" } },
			section_b = { { type = "string", custom = false, name = "hovered_size" } },
			section_c = {
				{ type = "string", custom = false, name = "hovered_name" },
				{ type = "coloreds", custom = false, name = "count", params = "true" },
			},
		},
		right = {
			section_a = { { type = "line", custom = false, name = "tabs", params = { "right" } } },
			section_b = {},
			section_c = {
				{ type = "string", custom = false, name = "cursor_position" },
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},
}

local githead_config = {
	theme = catppuccin_theme,
	branch_symbol = "",
	branch_borders = "",
}

require("border"):setup()
require("yatline"):setup(yatline_config)
-- require("githead"):setup(githead_config)

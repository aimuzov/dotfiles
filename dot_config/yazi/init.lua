local flavor = os.getenv("MACOS_IS_DARK") == "yes" and "macchiato" or "latte"
local catppuccin_theme = require("yatline-catppuccin"):setup(flavor)

catppuccin_theme.section_separator = { open = "", close = "" }
catppuccin_theme.part_separator = { open = "", close = "" }

require("yatline"):setup({
	theme = catppuccin_theme,
	show_background = true,

	header_line = {
		left = {
			section_a = { { type = "line", custom = false, name = "tabs", params = { "left" } } },
			section_b = {},
			section_c = {},
		},
		right = {
			section_a = {},
			section_b = { { type = "coloreds", custom = false, name = "githead" } },
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
			section_a = { { type = "string", custom = false, name = "cursor_position" } },
			section_b = {},
			section_c = {
				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
				{ type = "coloreds", custom = false, name = "permissions" },
			},
		},
	},
})

require("yatline-githead"):setup({
	theme = catppuccin_theme,
	branch_symbol = "",
	branch_borders = "",
})

require("duckdb"):setup()

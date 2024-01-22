local colorscheme = require("util.other").get_colorscheme()

local opts = {
	spec = {
		{ import = "plugins" },
		{ import = "plugins.coding" },
		{ import = "plugins.lang" },
		{ import = "plugins.linting" },
		{ import = "plugins.ui" },
		{ import = "plugins.ui.editor" },
		{ import = "plugins.ui.panels" },
	},
	install = { colorscheme = { colorscheme } },
	defaults = { lazy = true, version = false },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = false },
	diff = { cmd = "diffview.nvim" },
	ui = {
		border = "rounded",
		title = "  󱎦  󰫮  󰬇  󰬆  ",
		size = { width = 0.85, height = 0.8 },
		icons = { lazy = "", keys = "󰥻" },
	},
	performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
}

require("lazy").setup(opts)

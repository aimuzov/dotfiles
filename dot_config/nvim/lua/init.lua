local colorscheme = require("util").colorscheme_get_name()

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
	defaults = { lazy = false, version = false },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = false },
	diff = { cmd = "diffview.nvim" },
	ui = {
		border = "rounded",
		backdrop = 100,
		title = "  󱎦  󰫮  󰬇  󰬆  ",
		size = { width = 0.86, height = 0.72 },
		icons = { lazy = "(H) ", keys = "󰥻" },
	},
	performance = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
}

require("lazy").setup(opts)

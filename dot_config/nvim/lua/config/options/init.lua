local OptionsUtil = require("config.options.util")

local options = {
	autochdir = false,
	swapfile = false,
	backup = true,
	backupdir = vim.fn.getenv("HOME") .. "/.local/state/nvim/backup/",
	smoothscroll = true,
	conceallevel = 2,

	expandtab = false,
	smarttab = true,
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,
	autoindent = true,

	pumblend = 15,
	winblend = 5,

	timeout = true,
	timeoutlen = 500,
	ttimeoutlen = 0,

	showmode = false,
	ruler = false,

	showbreak = "↪",
	listchars = { eol = "↩", space = "·", tab = "→ " },
	fillchars = {
		diff = " ",
		eob = " ",

		fold = "╌",

		horiz = "━",
		horizup = "┻",
		horizdown = "┳",
		vert = "┃",
		vertleft = "┫",
		vertright = "┣",
		verthoriz = "╋",
	},

	spelllang = "",
	langmap = OptionsUtil.langmap_create(),
}

OptionsUtil.options_apply(options)
OptionsUtil.mouse_context_menu_fix()

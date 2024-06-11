local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyurl = "https://github.com/folke/lazy.nvim.git"

local lazyopts = {
	spec = {
		{ "aimuzov/LazyVimx", import = "lazyvimx.core" },
		{ import = "lazyvimx.colorschemes.catppuccin" }, -- catppuccin | tokyonight
	},

	--------------------------------------------------------------------------------------------------------------------

	dev = { path = "~/projects/github/aimuzov", patterns = { "LazyVimx" } },
	install = { colorscheme = { "catppuccin", "tokyonight" } },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = false },
	diff = { cmd = "diffview.nvim" },

	ui = {
		backdrop = 100,
		border = "rounded",
		icons = { lazy = "(H) ", keys = "󰥻" },
		title = "  󱎦  󰫮  󰬇  󰬆  ",
	},
}

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", lazyurl, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup(lazyopts)

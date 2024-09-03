local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyurl = "https://github.com/folke/lazy.nvim.git"

local lazyopts = {
	spec = {
		{ "aimuzov/LazyVimx", import = "lazyvimx.core" },
		{ import = "lazyvimx.colorschemes.catppuccin" }, -- catppuccin | tokyonight
	},

	install = { colorscheme = { "catppuccin", "tokyonight" } },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = false },
	diff = { cmd = "diffview.nvim" },

	ui = {
		backdrop = 100,
		border = "rounded",
		icons = { lazy = "(H) ", keys = "󰥻" },
	},
}

if vim.fn.isdirectory(vim.fn.getenv("HOME") .. "/projects/github/aimuzov/LazyVimx") ~= 0 then
	lazyopts.dev = {
		path = vim.fn.getenv("HOME") .. "/projects/github/aimuzov",
		patterns = { "LazyVimx" },
	}
end

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", lazyurl, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup(lazyopts)

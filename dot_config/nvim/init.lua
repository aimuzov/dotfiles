local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyurl = "https://github.com/folke/lazy.nvim.git"

local lazyopts = {
	dev = { path = "~/projects/github/aimuzov", patterns = { "LazyVimEnhanced" } },

	spec = {
		{ "aimuzov/LazyVimEnhanced", config = true },
		{ import = "lazyvimenhanced.plugins" },
		{ import = "lazyvimenhanced.plugins.colorschemes.catppuccin" },
	},

	install = { colorscheme = { "catppuccin", "tokyonight" } },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = false },
	diff = { cmd = "diffview.nvim" },
	ui = {
		backdrop = 100,
		border = "rounded",
		icons = { lazy = "(H) ", keys = "󰥻" },
		size = { width = 0.9, height = 0.8 },
		title = "  󱎦  󰫮  󰬇  󰬆  ",

		custom_keys = {
			["gx"] = {
				-- stylua: ignore
				function(plugin) vim.cmd(":!open " .. plugin.url:gsub("%.git", "") .. "/issues/" .. vim.fn.expand("<cword>")) end,
				desc = "Open issue or pull request under cursor",
			},
		},
	},
}

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", lazyurl, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
require("lazy").setup(lazyopts)

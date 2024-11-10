local lazy_opts = {
	spec = {
		{ "aimuzov/LazyVimx", import = "lazyvimx.core" },
		{ import = "lazyvimx.colorschemes.catppuccin" },
		-- { import = "lazyvimx.colorschemes.tokyonight" },
	},

	install = { colorscheme = { "catppuccin", "tokyonight" } },
	checker = { enabled = true, notify = false },
	change_detection = { enabled = false },
	diff = { cmd = "diffview.nvim" },

	ui = {
		backdrop = 100,
		border = "rounded",
		size = { width = 0.84, height = 0.62 },
		icons = { lazy = "(H) ", keys = "󰥻" },
	},
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local lazydev_path = vim.fn.getenv("HOME") .. "/projects/lazy-dev"

if vim.fn.isdirectory(lazydev_path) ~= 0 then
	lazy_opts.dev = {
		path = lazydev_path,
		patterns = { "" },
		fallback = true,
	}
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_url = "https://github.com/folke/lazy.nvim.git"

vim.opt.rtp:prepend(vim.env.LAZY or lazy_path)

if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", lazy_url, "--branch=stable", lazy_path })
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

require("lazy").setup(lazy_opts)

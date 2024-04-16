local AutocmdsUtil = require("config.autocmds.util")

vim.api.nvim_create_autocmd("Signal", {
	desc = "Change colorscheme after system theme changed",
	callback = vim.schedule_wrap(AutocmdsUtil.colorscheme_update),
})

vim.api.nvim_create_autocmd("ColorScheme", {
	desc = "Setup plugins after colorscheme changed",
	callback = vim.schedule_wrap(AutocmdsUtil.plugins_setup),
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyUpdate",
	desc = "Update dotfiles (chezmoi apply)",
	callback = vim.schedule_wrap(AutocmdsUtil.chezmoi_update),
})

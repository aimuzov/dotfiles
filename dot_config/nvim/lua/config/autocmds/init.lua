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

vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePre*",
	desc = "Disable scrollbar",
	callback = AutocmdsUtil.scroll_disable,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePost*",
	desc = "Enable scrollbar",
	callback = AutocmdsUtil.scroll_enable,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePost*",
	desc = "Open dashboard on close last buffer",
	callback = AutocmdsUtil.dashboard_launch_on_close_last_buffer,
})

vim.api.nvim_create_autocmd("TabNewEntered", {
	desc = "Open dashboard on tab new entered",
	callback = AutocmdsUtil.dashboard_launch_on_new_tab,
})

vim.api.nvim_create_autocmd("BufHidden", {
	desc = "Delete [No Name] buffers",
	callback = AutocmdsUtil.empty_buffers_close,
})

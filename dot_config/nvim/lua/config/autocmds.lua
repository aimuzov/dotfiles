local LazyvimUtil = require("lazyvim.util")
local Util = require("util")

vim.api.nvim_create_autocmd("Signal", {
	callback = vim.schedule_wrap(Util.colorscheme_change),
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = vim.schedule_wrap(function()
		require("lualine").setup({ options = { theme = Util.lualine_theme_create() } })
		require("nvim-web-devicons").set_up_highlights(true)
	end),
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyUpdate",
	callback = vim.schedule_wrap(function()
		local handle = io.popen("chezmoi add ~/.config/nvim/lazy-lock.json 2>&1", "r")
		local result_raw = handle ~= nil and handle:read("*a")
		local result_safety = result_raw:gsub("[\n\r]", "")
		local message = result_safety == "" and "[chezmoi] lazy-lock.json applied" or "[chezmoi] " .. result_safety

		vim.print(message)

		if handle ~= nil then
			handle:close()
		end
	end),
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePre*",
	callback = function()
		if LazyvimUtil.has("satellite.nvim") then
			require("satellite.view").disable()
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePost*",
	callback = function()
		if LazyvimUtil.has("satellite.nvim") then
			require("satellite.view").enable()
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePost*",
	callback = function(event)
		if LazyvimUtil.has("alpha-nvim") then
			local fallback_name = vim.api.nvim_buf_get_name(event.buf)
			local fallback_ft = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
			local fallback_on_empty = fallback_name == "" and fallback_ft == ""

			if fallback_on_empty then
				require("alpha").start()
				vim.cmd("bw #")
			end
		end
	end,
})

vim.api.nvim_create_autocmd("TabNewEntered", {
	desc = "Open dashboard on tab new entered",
	callback = function(event)
		if
			event.file == ""
			and vim.bo[event.buf].buftype == ""
			and not vim.bo[event.buf].modified
			and LazyvimUtil.has("alpha-nvim")
		then
			vim.schedule(require("alpha").start)
		end
	end,
})

vim.api.nvim_create_autocmd("BufHidden", {
	desc = "Delete [No Name] buffers",
	callback = function(event)
		if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
			vim.schedule(function()
				pcall(vim.api.nvim_buf_delete, event.buf, {})
			end)
		end
	end,
})

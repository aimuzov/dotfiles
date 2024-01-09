local lazy_util = require("lazyvim.util")
local util = require("util.other")
local util_hi = require("util.hi")

vim.api.nvim_create_autocmd("Signal", {
	pattern = "*",
	callback = function()
		vim.cmd.colorscheme(util.get_colorscheme())
		vim.cmd([[Lazy reload bufferline.nvim]])
		require("lualine").setup({})
		util_hi.highlights_override()
		util_hi.highlights_override_hack()
		require("nvim-web-devicons").set_up_highlights(true)
		vim.cmd([[Lazy reload indent-blankline.nvim]])
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = util_hi.highlights_override_start_logo_anim,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = util_hi.highlights_override,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyVimStarted",
	callback = util_hi.highlights_override_hack,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyUpdate",
	callback = function()
		local handle = io.popen("chezmoi add ~/.config/nvim/lazy-lock.json 2>&1", "r")
		local result_raw = handle ~= nil and handle:read("*a")
		local result_safety = result_raw:gsub("[\n\r]", "")
		local message = result_safety == "" and "[chezmoi] lazy-lock.json applied" or "[chezmoi] " .. result_safety

		vim.print(message)

		if handle ~= nil then
			handle:close()
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePre*",
	callback = function()
		if lazy_util.has("satellite.nvim") then
			require("satellite.view").disable()
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePost*",
	callback = function()
		if lazy_util.has("satellite.nvim") then
			require("satellite.view").enable()
		end
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePost*",
	callback = function(event)
		if lazy_util.has("alpha-nvim") then
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
			and lazy_util.has("alpha-nvim")
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

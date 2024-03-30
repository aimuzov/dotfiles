local Util = require("util")
local M = {}

function M.colorscheme_update()
	vim.cmd.colorscheme(Util.colorscheme_get_name())
end

function M.plugins_setup()
	if LazyVim.has("nvim-web-devicons") then
		require("nvim-web-devicons").set_up_highlights(true)
	end
end

function M.chezmoi_update()
	if vim.fn.executable("chezmoi") ~= 1 then
		return
	end

	local handle = io.popen("chezmoi add ~/.config/nvim/lazy-lock.json ~/.config/nvim/lazyvim.json 2>&1", "r")
	local result_raw = handle ~= nil and handle:read("*a")
	local result_safety = result_raw:gsub("[\n\r]", "")
	local message = result_safety == "" and "[chezmoi] lazy-lock.json & lazyvim.json applied"
		or "[chezmoi] " .. result_safety

	vim.print(message)

	if handle ~= nil then
		handle:close()
	end
end

function M.scroll_disable()
	if LazyVim.has("satellite.nvim") then
		require("satellite.view").disable()
	end
end

function M.scroll_enable()
	if LazyVim.has("satellite.nvim") then
		require("satellite.view").enable()
	end
end

function M.dashboard_launch_on_close_last_buffer(event)
	if not LazyVim.has("alpha-nvim") then
		return
	end

	local fallback_name = vim.api.nvim_buf_get_name(event.buf)
	local fallback_ft = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
	local fallback_on_empty = fallback_name == "" and fallback_ft == ""

	if fallback_on_empty then
		require("alpha").start()
		vim.cmd("bw #")
	end
end

function M.dashboard_launch_on_new_tab(event)
	if not LazyVim.has("alpha-nvim") then
		return
	end

	local fallback_on_empty = event.file == "" and vim.bo[event.buf].buftype == ""
	local buffer_not_modifed = not vim.bo[event.buf].modified

	if fallback_on_empty and buffer_not_modifed then
		vim.schedule(require("alpha").start)
	end
end

function M.empty_buffers_close(event)
	local fallback_on_empty = event.file == "" and vim.bo[event.buf].buftype == ""
	local buffer_not_modifed = not vim.bo[event.buf].modified

	if fallback_on_empty and buffer_not_modifed then
		vim.schedule(function()
			pcall(vim.api.nvim_buf_delete, event.buf, {})
		end)
	end
end

return M

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

return M

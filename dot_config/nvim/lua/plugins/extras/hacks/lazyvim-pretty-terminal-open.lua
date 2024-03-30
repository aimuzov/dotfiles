local function override_terminal_open()
	vim.g.lazygit_config = false

	local open_original = LazyVim.terminal.open

	LazyVim.terminal.open = function(cmd, opts)
		opts = vim.tbl_deep_extend("force", opts or {}, {
			backdrop = 100,
			size = { width = 0.83, height = 0.72 },
			margin = { top = 1, bottom = 0 },
			zindex = 60,
		})

		if cmd ~= nil and cmd[1] == "lazygit" then
			local theme = require("util").os_theme_is_dark() and "dark" or "light"
			local cfg_dir = vim.fn.getenv("HOME") .. "/.config/lazygit"

			opts = vim.tbl_deep_extend("force", opts or {}, {
				border = "none",
				env = { ["LG_CONFIG_FILE"] = cfg_dir .. "/config.yml," .. cfg_dir .. "/theme-" .. theme .. ".yml" },
				size = { height = 1, width = 1 },
				margin = { top = 0, bottom = 1 },
			})
		end

		open_original(cmd, opts)
	end
end

return {
	"LazyVim/LazyVim",
	opts = override_terminal_open,
}

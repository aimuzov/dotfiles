local lazy_util = require("lazyvim.util")
local current_line_blame = nil
local diagnostic_is_disabled = false

return {
	{
		"folke/twilight.nvim",
		optional = true,
		opts = {
			dimming = {
				alpha = 0.35,
			},

			context = 20,
		},
	},

	{
		"folke/zen-mode.nvim",
		optional = true,
		event = "VeryLazy",
		opts = {
			window = {
				backdrop = 0.95,
				width = 120,
				height = 1,
				options = {
					list = false,
					number = false,
					relativenumber = false,
					wrap = true,
				},
			},

			plugins = {
				options = { enabled = true, laststatus = 0 },
				kitty = { enabled = false },
				gitsigns = { enabled = true },
			},

			on_open = function(win)
				diagnostic_is_disabled = vim.diagnostic.is_disabled(win)

				vim.diagnostic.disable()

				if lazy_util.has("indent-blankline.nvim") then
					vim.cmd("IBLDisable")
				end

				if lazy_util.has("satellite.nvim") then
					vim.cmd("SatelliteDisable")
				end

				-- if lazy_util.has("gitsigns.nvim") then
				-- 	current_line_blame = require("gitsigns.config").config.current_line_blame
				--
				-- 	if current_line_blame then
				-- 		vim.cmd("Gitsigns toggle_current_line_blame")
				-- 	end
				-- end
			end,

			on_close = function()
				if not diagnostic_is_disabled then
					vim.diagnostic.enable()
				end

				if lazy_util.has("indent-blankline.nvim") then
					vim.cmd("IBLEnable")
				end

				if lazy_util.has("satellite.nvim") then
					vim.cmd("SatelliteDisable")
				end

				if lazy_util.has("gitsigns.nvim") then
					if current_line_blame then
						require("gitsigns.actions").toggle_current_line_blame(nil)
					end
				end
			end,
		},
		keys = {
			{ "<leader>uz", [[<cmd>ZenMode<cr>]], desc = "Toggle zen mode" },
		},
	},
}

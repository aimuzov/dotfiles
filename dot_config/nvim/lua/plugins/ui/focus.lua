local diagnostic_is_disabled = false

return {
	{
		"folke/twilight.nvim",
		optional = true,
		opts = {
			dimming = {
				alpha = 0.35,
			},

			context = 40,
		},
	},

	{
		"folke/zen-mode.nvim",
		optional = true,
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
				wezterm = { enabled = true, font = "+2" },
			},

			on_open = function(win)
				diagnostic_is_disabled = vim.diagnostic.is_disabled(win)

				vim.diagnostic.disable()

				if vim.fn.exists(":IBLDisable") > 0 then
					vim.cmd("IBLDisable")
				end

				if vim.fn.exists(":SatelliteDisable") > 0 then
					vim.cmd("SatelliteDisable")
				end
			end,

			on_close = function()
				if not diagnostic_is_disabled then
					vim.diagnostic.enable()
				end

				if vim.fn.exists(":IBLEnable") > 0 then
					vim.cmd("IBLEnable")
				end

				if vim.fn.exists(":SatelliteDisable") > 0 then
					vim.cmd("SatelliteDisable")
				end
			end,
		},
		keys = {
			{ "<leader>uz", [[<cmd>ZenMode<cr>]], desc = "Toggle zen mode" },
		},
	},
}

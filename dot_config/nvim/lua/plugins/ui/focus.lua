local diagnostic_is_disabled = false

return {
	{
		"folke/twilight.nvim",
		optional = true,
		opts = {
			dimming = { alpha = 0.35 },
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
				gitsigns = { enabled = true },
				kitty = { enabled = false },
				options = { enabled = true, laststatus = 0 },
				wezterm = { enabled = true, font = "+2" },
			},

			on_open = function(win)
				local bufnr = vim.fn.winbufnr(win)

				diagnostic_is_disabled = vim.diagnostic.is_disabled(bufnr)

				vim.keymap.set("n", "q", "<cmd>close<cr>", { silent = true })
				vim.diagnostic.disable()

				if vim.fn.exists(":IBLDisable") > 0 then
					vim.cmd("IBLDisable")
				end

				if vim.fn.exists(":SatelliteDisable") > 0 then
					vim.cmd("SatelliteDisable")
				end
			end,

			on_close = function()
				vim.keymap.del("n", "q", { silent = true })

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

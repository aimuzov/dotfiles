return {
	"nvim-telescope/telescope.nvim",
	dependencies = { { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-lua/plenary.nvim" } } },

	opts = {
		extensions = {
			file_browser = {
				path = "%:p:h",
				select_buffer = true,
				display_stat = { size = true, date = true },
			},
		},
	},

	keys = {
		{ "<leader>fd", "<cmd>Telescope file_browser<cr>", desc = "Buffers (all)" },
	},
}

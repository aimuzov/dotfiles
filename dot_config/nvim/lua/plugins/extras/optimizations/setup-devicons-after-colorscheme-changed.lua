return {
	"nvim-tree/nvim-web-devicons",
	optional = true,
	opts = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			desc = "Setup plugin (icons) after colorscheme changed",
			callback = vim.schedule_wrap(function()
				require("nvim-web-devicons").set_up_highlights(true)
			end),
		})
	end,
}

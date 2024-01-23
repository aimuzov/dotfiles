return {
	{
		"tpope/vim-fugitive",
		optional = true,
	},

	{
		"shumphrey/fugitive-gitlab.vim",
		optional = true,
		dependencies = { "tpope/vim-fugitive" },
		init = function()
			vim.g.gitlab_api_keys = { ["gitlab.com"] = vim.fn.getenv("GITLAB_TOKEN") }
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		optional = true,
		opts = {
			preview_config = {
				border = "rounded",
				row = 1,
				col = 1,
			},
		},
	},
}

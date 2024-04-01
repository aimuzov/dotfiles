return {
	"shumphrey/fugitive-gitlab.vim",
	dependencies = { "tpope/vim-fugitive" },

	init = function()
		vim.g.gitlab_api_keys = {
			["gitlab.com"] = vim.fn.getenv("GITLAB_TOKEN"),
		}
	end,
}

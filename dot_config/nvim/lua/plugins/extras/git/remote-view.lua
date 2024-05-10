return {
	"moyiz/git-dev.nvim",
	event = "VeryLazy",

	opts = {
		cd_type = "tab",
		opener = function(dir, repo_uri)
			vim.print("Opening " .. repo_uri)
			vim.cmd("tabnew")
			vim.schedule(function()
				vim.cmd("Neotree")
			end)
		end,
	},

	keys = {
		{
			"<leader>gO",
			function()
				local repo = vim.fn.input("Repository name / URI: ")

				if repo ~= "" then
					require("git-dev").open(repo)
				end
			end,
			desc = "[O]pen a remote git repository",
		},
	},
}

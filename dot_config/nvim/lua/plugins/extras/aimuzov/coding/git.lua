return {
	{
		"tpope/vim-fugitive",
	},

	{
		"shumphrey/fugitive-gitlab.vim",
		dependencies = { "tpope/vim-fugitive" },
		init = function()
			vim.g.gitlab_api_keys = { ["gitlab.com"] = vim.fn.getenv("GITLAB_TOKEN") }
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = function(_, opts)
			local on_attach_orig = opts.on_attach
			local on_attach_modified = function(buffer)
				local keyOpts = { buffer = buffer, desc = "Preview Hunk" }
				vim.keymap.set("n", "<leader>ghP", require("gitsigns").preview_hunk, keyOpts)
				on_attach_orig(buffer)
			end

			opts.on_attach = on_attach_modified
			opts.preview_config = vim.tbl_extend("force", opts.preview_config or {}, { row = 1, col = 1 })
		end,
	},

	{
		"Almo7aya/openingh.nvim",
		keys = {
			{ "<leader>go", "<cmd>OpenInGHFile<cr>", desc = "Open in github/gitlab", mode = { "n" } },
			{ "<leader>go", "<esc><cmd>'<,'>OpenInGHFileLines<cr>", desc = "Open in github/gitlab", mode = { "v" } },
		},
	},

	{
		"harrisoncramer/gitlab.nvim",

		config = true,

		dependencies = {
			{ "MunifTanjim/nui.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "sindrets/diffview.nvim" },
			{ "stevearc/dressing.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
			{
				"folke/which-key.nvim",
				opts = { defaults = { ["<leader>gl"] = { name = "+gitlab" } } },
			},
		},

		build = function()
			require("gitlab.server").build(true)
		end,

		opts = {
			attachment_dir = vim.fn.getenv("HOME") .. "/temp/screenshots",
			discussion_tree = {
				auto_open = false,
				position = "bottom",
			},

			merge = {
				squash = true,
			},
		},

		keys = {
			{ "<leader>glr", [[<cmd>lua require("gitlab").review()<cr>]], desc = "review" },
			{ "<leader>gls", [[<cmd>lua require("gitlab").summary()<cr>]], desc = "summary" },
			{ "<leader>glA", [[<cmd>lua require("gitlab").approve()<cr>]], desc = "approve" },
			{ "<leader>glR", [[<cmd>lua require("gitlab").revoke()<cr>]], desc = "revoke" },
			{ "<leader>glc", [[<cmd>lua require("gitlab").create_comment()<cr>]], desc = "create comment" },
			-- stylua: ignore start
			{ "<leader>glc", [[<cmd>lua require("gitlab").create_multiline_comment()<cr>]], desc = "create comment", mode = { "v" } },
			{ "<leader>glC", [[<cmd>lua require("gitlab").create_comment_suggestion()<cr>]], desc = "create comment suggestion", mode = { "v" } },
			{ "<leader>glm", [[<cmd>lua require("gitlab").move_to_discussion_tree_from_diagnostic()<cr>]], desc = "move to discussion" },
			-- stylua: ignore end
			{ "<leader>gln", [[<cmd>lua require("gitlab").create_note()<cr>]], desc = "create note" },
			{ "<leader>gld", [[<cmd>lua require("gitlab").toggle_discussions()<cr>]], desc = "toggle discussion" },
			{ "<leader>glp", [[<cmd>lua require("gitlab").pipeline()<cr>]], desc = "pipeline" },
			{ "<leader>glo", [[<cmd>lua require("gitlab").open_in_browser()<cr>]], desc = "open in browser" },
			{ "<leader>glM", [[<cmd>lua require("gitlab").merge()<cr>]], desc = "merge" },
		},
	},
}

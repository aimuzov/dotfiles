return {
	{
		"jackMort/ChatGPT.nvim",
		optional = true,
		config = true,

		opts = {
			actions_paths = { "~/.config/nvim/util/chatgpt-actions.json" },
			chat = {
				loading_text = "",
				question_sign = "",
				border_left_sign = " ",
				border_right_sign = "",
			},
			popup_window = {
				border = {
					text = { top = "  󰫰 󰫵 󰫮 󰬁   󰫴 󰫽 󰬁  " },
				},
			},
			popup_input = {
				prompt = "  ",
				border = {
					text = { top = "" },
				},
			},
		},

		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"folke/trouble.nvim",
			{
				"folke/which-key.nvim",
				opts = { defaults = { ["<leader>p"] = { name = "+chatgpt" } } },
			},
		},

		keys = {
			-- stylua: ignore start
			{ "<leader>pc", "<cmd>ChatGPT<cr>", desc = "ChatGPT", mode = { "n", "v" } },
			{ "<leader>pe", "<cmd>ChatGPTEditWithInstruction<cr>", desc = "Edit with instruction", mode = { "n", "v" } },
			{ "<leader>pg", "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Grammar Correction", mode = { "n", "v" } },
			{ "<leader>pt", "<cmd>ChatGPTRun translate<cr>", desc = "Translate", mode = { "n", "v" } },
			{ "<leader>pk", "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords", mode = { "n", "v" } },
			{ "<leader>pd", "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring", mode = { "n", "v" } },
			{ "<leader>pa", "<cmd>ChatGPTRun add_tests<cr>", desc = "Add Tests", mode = { "n", "v" } },
			{ "<leader>po", "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize Code", mode = { "n", "v" } },
			{ "<leader>ps", "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize", mode = { "n", "v" } },
			{ "<leader>pf", "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix Bugs", mode = { "n", "v" } },
			{ "<leader>px", "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain Code", mode = { "n", "v" } },
			{ "<leader>pt", "<cmd>ChatGPTRun translate<cr>", desc = "Translate", mode = { "n", "v" } },
			{ "<leader>pk", "<cmd>ChatGPTRun keywords<cr>", desc = "Keywords", mode = { "n", "v" } },
			{ "<leader>pd", "<cmd>ChatGPTRun docstring<cr>", desc = "Docstring", mode = { "n", "v" } },
			{ "<leader>pa", "<cmd>ChatGPTRun add_tests<cr>", desc = "Add Tests", mode = { "n", "v" } },
			{ "<leader>po", "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize Code", mode = { "n", "v" } },
			{ "<leader>ps", "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize", mode = { "n", "v" } },
			{ "<leader>pf", "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix Bugs", mode = { "n", "v" } },
			{ "<leader>px", "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain Code", mode = { "n", "v" } },
			{ "<leader>pl", "<cmd>ChatGPTRun code_readability_analysis<cr>", desc = "Code Readability Analysis", mode = { "n", "v" } },
			-- stylua: ignore end
		},
	},

	{
		"piersolenski/wtf.nvim",
		optional = true,

		opts = {
			openai_api_key = vim.fn.getenv("OPENAI_API_KEY"),
			openai_model_id = "gpt-3.5-turbo",
			language = "russian",
		},

		keys = {
			{
				"<leader>cD",
				[[<cmd>lua require("wtf").ai()<cr>]],
				desc = "Debug diagnostic with AI",
				mode = { "n", "x" },
			},
			{
				"<leader>cg",
				[[<cmd>lua require("wtf").search()<cr>]],
				desc = "Search diagnostic with Google",
				mode = { "n" },
			},
		},
	},
}

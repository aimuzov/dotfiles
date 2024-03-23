return {
	{
		"max397574/better-escape.nvim",
		opts = {
			timeout = 100,
			mapping = { "jk", "ол" },
		},
	},

	{
		"brenton-leighton/multiple-cursors.nvim",
		optional = true,
		opts = {
			pre_hook = function()
				vim.opt.cursorline = false
				vim.g.minipairs_disable = true
				vim.cmd("NoMatchParen")
			end,
			post_hook = function()
				vim.opt.cursorline = true
				vim.g.minipairs_disable = false
				vim.cmd("DoMatchParen")
			end,
		},
		keys = {
			{ "<c-n>", "<cmd>MultipleCursorsAddJumpNextMatch<cr>", mode = { "n", "x" } },
		},
	},

	{
		"folke/flash.nvim",
		optional = true,
		opts = { modes = { search = { enabled = false } } },
	},

	{
		"Wansmer/sibling-swap.nvim",
		optional = true,
		dependencies = { "nvim-treesitter" },
		opts = {
			highlight_node_at_cursor = { hl_opts = { link = "Search" } },
			use_default_keymaps = false,
		},
		keys = {
			{ "<c-,>", [[<cmd>lua require('sibling-swap').swap_with_left()<cr>]] },
			{ "<c-.>", [[<cmd>lua require('sibling-swap').swap_with_right()<cr>]] },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		optional = true,
		opts = {
			on_attach = function(buf)
				local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

				if ft == "" or ft == "svelte" then
					return false
				end

				return true
			end,
		},
		keys = {
			{ "[x", [[<cmd>lua require("treesitter-context").go_to_context()<cr>]] },
		},
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_, opts)
			require("harpoon"):setup(opts)
		end,

		keys = {
			{
				"<c-e>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list(), {
						border = "rounded",
						title = "",
						ui_max_width = 80,
					})
				end,
				desc = "Open harpoon window",
				mode = { "n" },
			},

			{
				"<leader>fa",
				[[<cmd>lua require("harpoon"):list():append()<cr>]],
				desc = "Append file to harpoon list",
			},

			{ "<c-1>", [[<cmd>lua require("harpoon"):list():select(1)<cr>]], desc = "Harpooning 1" },
			{ "<c-2>", [[<cmd>lua require("harpoon"):list():select(2)<cr>]], desc = "Harpooning 2" },
			{ "<c-3>", [[<cmd>lua require("harpoon"):list():select(3)<cr>]], desc = "Harpooning 3" },
			{ "<c-4>", [[<cmd>lua require("harpoon"):list():select(4)<cr>]], desc = "Harpooning 4" },
			{ "<c-5>", [[<cmd>lua require("harpoon"):list():select(5)<cr>]], desc = "Harpooning 5" },
		},
	},
}

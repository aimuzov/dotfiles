return {
	{
		"max397574/better-escape.nvim",
		opts = {
			timeout = 100,
			mapping = { "jk" },
		},
	},

	{
		"brenton-leighton/multiple-cursors.nvim",
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
		opts = { modes = { search = { enabled = false } } },
	},

	{
		"Wansmer/sibling-swap.nvim",
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
		optional = true,

		keys = {
			{
				"<leader>h",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list(), {
						border = "rounded",
						title = "",
						ui_max_width = 80,
					})
				end,
				desc = "Harpoon Quick Menu",
			},
		},
	},
}

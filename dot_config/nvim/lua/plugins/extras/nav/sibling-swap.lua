return {
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
}

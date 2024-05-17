return {
	"nvim-treesitter/nvim-treesitter-context",
	optional = true,
	keys = {
		{ "[x", [[<cmd>lua require("treesitter-context").go_to_context(vim.v.count1)<cr>]], desc = "Go to context" },
	},
}

return {
	"nvim-treesitter/nvim-treesitter-context",
	optional = true,
	keys = {
		{ "[c", [[<cmd>lua require("treesitter-context").go_to_context()<cr>]] },
	},
}

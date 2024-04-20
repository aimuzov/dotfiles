return {
	"tiagovla/scope.nvim",
	config = true,
	keys = {
		{
			"<leader>b<tab>",
			[[<cmd>lua require("scope.core").move_current_buf({})<cr>]],
			desc = "Move buffer",
		},
	},
}

return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "tiagovla/scope.nvim" },

	keys = {
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers (per tab)" },
		{ "<leader>fB", "<cmd>Telescope scope buffers<cr>", desc = "Buffers (all)" },
	},
}

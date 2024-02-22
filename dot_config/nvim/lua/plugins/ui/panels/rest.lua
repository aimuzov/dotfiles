return {
	{
		"rest-nvim/rest.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		main = "rest-nvim",
		optional = true,
		config = true,
		keys = {
			{ "<cr>", [[<cmd>lua require("rest-nvim").run()<cr>]], ft = "http" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,

		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "http" })
			end
		end,
	},
}

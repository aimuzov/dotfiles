return {
	{
		"vhyrro/luarocks.nvim",
		optional = true,
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		main = "rest-nvim",
		optional = true,
		config = true,
		ft = "http",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"vhyrro/luarocks.nvim",
		},
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

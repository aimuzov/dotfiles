return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		optional = true,
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		optional = true,
		config = true,
		main = "rest-nvim",
		ft = "http",
		dependencies = { "vhyrro/luarocks.nvim" },
		keys = {
			{ "<cr>", [[<cmd>lua require("rest-nvim").run()<cr>]], ft = "http" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,

		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "lua", "xml", "http", "json", "graphql" })
			end
		end,
	},
}

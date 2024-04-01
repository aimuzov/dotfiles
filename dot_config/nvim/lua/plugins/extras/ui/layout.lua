return {
	{
		"folke/edgy.nvim",
		optional = true,

		opts = {
			animate = { enabled = false },
			exit_when_last = true,
			wo = { winbar = false },
			left = {
				{ ft = "neo-tree", size = { width = 40 } },
			},

			keys = {
				-- stylua: ignore start
				["<c-a-l>"] = function(win) win:resize("width", 3) end,
				["<c-a-h>"] = function(win) win:resize("width", -3) end,
				["<c-a-k>"] = function(win) win:resize("height", 3) end,
				["<c-a-j>"] = function(win) win:resize("height", -3) end,
				-- stylua: ignore end
			},
		},

		keys = {
			{ "<c-a-k>", "<cmd>resize +3<cr>", mode = { "n", "v", "t" }, desc = "Increase window height" },
			{ "<c-a-j>", "<cmd>resize -3<cr>", mode = { "n", "v", "t" }, desc = "Decrease window height" },
			{ "<c-a-h>", "<cmd>vertical resize -3<cr>", mode = { "n", "v", "t" }, desc = "Decrease window width" },
			{ "<c-a-l>", "<cmd>vertical resize +3<cr>", mode = { "n", "v", "t" }, desc = "Increase window width" },
		},
	},
}

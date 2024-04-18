return {
	{
		"folke/edgy.nvim",
		optional = true,
		opts = function(_, opts)
			table.insert(opts.bottom, { ft = "dap-repl" })

			for i, v in pairs(opts.bottom) do
				if v.ft == "lazyterm" then
					table.remove(opts.bottom, i)
					break
				end
			end
		end,
	},

	{
		"folke/edgy.nvim",
		optional = true,

		opts = {
			animate = { enabled = false },
			exit_when_last = true,
			wo = { winbar = false },

			options = {
				left = { size = 40 },
				right = { size = 40 },
				bottom = { size = 10 },
			},

			left = {
				{ ft = "neo-tree" },
				{ ft = "dapui_scopes" },
				{ ft = "dapui_breakpoints" },
				{ ft = "dapui_stacks" },
				{ ft = "dapui_watches" },
			},

			right = {
				{ ft = "neotest-summary" },
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

	{
		"rcarriga/nvim-dap-ui",
		optional = true,
		opts = {
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					position = "left",
					size = 40,
				},

				{
					elements = { { id = "repl", size = 1 } },
					position = "bottom",
					size = 10,
				},
			},
		},
	},
}

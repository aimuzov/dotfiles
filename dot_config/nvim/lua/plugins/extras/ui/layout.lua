local size = { left = 40, right = 40, top = 10, bottom = 10 }

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

			opts.keys = {
				["<c-a-l>"] = function(win)
					size[win.view.edgebar.pos] = win.width + 3
					win:resize("width", 3)
				end,
				["<c-a-h>"] = function(win)
					size[win.view.edgebar.pos] = win.width - 3
					win:resize("width", -3)
				end,
				["<c-a-k>"] = function(win)
					size[win.view.edgebar.pos] = win.height + 3
					win:resize("height", 3)
				end,
				["<c-a-j>"] = function(win)
					size[win.view.edgebar.pos] = win.height - 3
					win:resize("height", -3)
				end,
			}
		end,
	},

	{
		"folke/edgy.nvim",
		optional = true,

		opts = {
			animate = { enabled = false },
			exit_when_last = true,
			wo = { winfixwidth = false, winbar = false },

			options = {
				-- stylua: ignore start
				left =		{ size = function() return size.left end, },
				right =		{ size = function() return size.right end, },
				top =		{ size = function() return size.top end, },
				bottom =	{ size = function() return size.bottom end, },
				-- stylua: ignore end
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

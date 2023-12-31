local filter_relative_empty = function(_, win)
	return vim.api.nvim_win_get_config(win).relative == ""
end

local show_letter_in_window = function(self, window, char)
	local point = self:_get_float_win_pos(window)
	local lines = vim.split(char, "\n")

	local buffer_id = vim.api.nvim_create_buf(false, true)
	local window_id = vim.api.nvim_open_win(buffer_id, false, {
		relative = "win",
		win = window,
		focusable = false,
		row = point.y,
		col = point.x,
		width = 4,
		height = 3,
		style = "minimal",
	})

	vim.api.nvim_buf_set_lines(buffer_id, 0, 0, true, lines)

	return window_id
end

return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		optional = true,

		dependencies = {
			{
				"akinsho/bufferline.nvim",
				optional = true,
				opts = function()
					local Offset = require("bufferline.offset")
					if not Offset.edgy then
						local get = Offset.get
						Offset.get = function()
							if package.loaded.edgy then
								local layout = require("edgy.config").layout
								local ret = {
									left = "%#EdgyTitle#%*",
									left_size = 0,
									right = "",
									right_size = 0,
								}
								local sb = layout["left"]
								if sb and #sb.wins > 0 then
									ret["left"] = "%#EdgyTitle#" .. string.rep(" ", sb.bounds.width) .. "%*"
									ret["left_size"] = sb.bounds.width
								end
								ret.total_size = ret.left_size + ret.right_size
								if ret.total_size > 0 then
									return ret
								end
							end
							return get()
						end
						Offset.edgy = true
					end
				end,
			},
		},

		keys = {
			{ "<leader>uh", [[<cmd>lua require("edgy").close()<cr>]], desc = "Edgy close windows" },
			{ "<c-m-k>", "<cmd>resize +3<cr>", mode = { "n", "v", "t" }, desc = "Increase window height" },
			{ "<c-m-j>", "<cmd>resize -3<cr>", mode = { "n", "v", "t" }, desc = "Decrease window height" },
			{ "<c-m-h>", "<cmd>vertical resize -3<cr>", mode = { "n", "v", "t" }, desc = "Decrease window width" },
			{ "<c-m-l>", "<cmd>vertical resize +3<cr>", mode = { "n", "v", "t" }, desc = "Increase window width" },
		},

		opts = {
			animate = { enabled = false },
			wo = {
				winbar = false,
				winfixwidth = false,
			},

			options = {
				left = { size = 10 },
				bottom = { size = 5 },
				right = { size = 40 },
			},

			left = {
				{ ft = "neo-tree", size = { width = 40 } },
			},

			right = {
				{ ft = "spectre_panel", size = { height = 0.8, width = 80 } },
				{ ft = "neotest-summary", size = { width = 40 } },
				{ ft = "aerial" },
				-- { ft = "dapui_scopes" },
				-- { ft = "dapui_watches" },
				-- { ft = "dapui_stacks" },
				-- { ft = "dapui_breakpoints", size = { height = 10 } },
			},

			bottom = {
				{ ft = "toggleterm", filter = filter_relative_empty, size = { height = 10 } },
				{ ft = "Trouble" },
				{ ft = "noice", filter = filter_relative_empty },
				-- { ft = "dap-repl" },
				-- { ft = "dapui_console" },
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
	},

	{
		"s1n7ax/nvim-window-picker",
		optional = true,

		dependencies = {
			{
				"nvim-neo-tree/neo-tree.nvim",
				optional = true,
				opts = function(_, opts)
					opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
						or { "terminal", "Trouble", "qf", "Outline" }
					table.insert(opts.open_files_do_not_replace_types, "edgy")
				end,
			},

			{
				"nvim-telescope/telescope.nvim",
				optional = true,
				opts = {
					defaults = {
						get_selection_window = function()
							require("edgy").goto_main()
							return 0
						end,
					},
				},
			},
		},

		opts = {
			hint = "floating-big-letter",
			selection_chars = "FJDKSLAGHCMTU",
			show_prompt = false,
			filter_rules = {
				bo = { filetype = { "noice", "", "notify", "neo-tree", "aerial" } },
			},
			picker_config = {
				floating_big_letter = {
					font = require("util.fonts").pretty,
				},
			},
		},
		init = function()
			require("window-picker.hints.floating-big-letter-hint")._show_letter_in_window = show_letter_in_window
		end,
		config = true,
		keys = {
			{
				"<leader>wp",
				function()
					local window_id = require("window-picker").pick_window()

					if window_id then
						vim.api.nvim_set_current_win(window_id)
					end
				end,
			},
		},
	},
}

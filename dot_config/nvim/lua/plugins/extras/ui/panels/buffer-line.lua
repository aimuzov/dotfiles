local buffer_move_create = function(dir)
	local cmd_next = "BufferLineMoveNext"
	local cmd_prev = "BufferLineMovePrev"

	return function()
		local M = {}

		function M.buffer_move(dir_next)
			vim.cmd(dir_next == "next" and cmd_next or cmd_prev)
			M.buffer_move_repeat()
		end

		function M.buffer_move_repeat()
			local char = vim.fn.getcharstr()

			if char == "]" then
				M.buffer_move("next")
			elseif char == "[" then
				M.buffer_move("prev")
			elseif char ~= nil then
				vim.api.nvim_feedkeys(vim.keycode(char), "m", true)
			end
		end

		M.buffer_move(dir)
	end
end

return {
	{
		"akinsho/bufferline.nvim",
		lazy = false,

		opts = {
			options = {
				always_show_bufferline = true,
				truncate_names = false,
				indicator = { icon = "▎", style = "icon" },
				separator_style = "thin",
				left_trunc_marker = "",
				right_trunc_marker = "",
				modified_icon = "",
				close_icon = "󰅖",
				offsets = {
					{ filetype = "neo-tree", separator = false, text = "" },
					{ filetype = "DiffviewFiles", separator = false, text = "" },
				},

				groups = {
					options = { toggle_hidden_on_enter = true },
					items = {},
				},

				custom_filter = function(buf)
					local ft = vim.bo[buf].filetype

					if ft == "alpha" then
						return false
					end

					return true
				end,
			},
		},

		keys = {
			{ "<leader>bg", "<cmd>BufferLinePick<cr>", mode = { "n", "v", "t" }, desc = "Pick Buffer" },
			{ "<leader>bm[", buffer_move_create("prev"), desc = "Move buffer (prev)" },
			{ "<leader>bm]", buffer_move_create("next"), desc = "Move buffer (next)" },
		},
	},

	{
		"akinsho/bufferline.nvim",

		opts = function(_, opts)
			local bufferline_groups = require("bufferline.groups")

			table.insert(opts.options.groups, bufferline_groups.builtin.pinned:with({ icon = "" }))
			table.insert(opts.options.groups, bufferline_groups.builtin.ungrouped)
		end,
	},
}

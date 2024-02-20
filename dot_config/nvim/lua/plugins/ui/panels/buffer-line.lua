local buffer_delete = function(buffer_number, force)
	local bufdelete = require("bufdelete").bufdelete
	local buffer_modified = vim.api.nvim_get_option_value("modified", { buf = buffer_number })

	if force or not buffer_modified then
		bufdelete(buffer_number, force)
		return
	end

	local buf_name = vim.api.nvim_buf_get_name(buffer_number)
	local message = buf_name == "" and "Save changes" or ("Save changes to %q?"):format(buf_name)
	local choice = vim.fn.confirm(message, "&Yep\n&Nop")

	if choice == 1 then -- Yes
		vim.cmd.write()
		bufdelete(buffer_number)
	elseif choice == 2 then -- No
		bufdelete(buffer_number, true)
	end
end

local buffer_delete_create = function(force)
	return function()
		local M = {}

		function M.buffer_delete(buffer_number, force)
			local buffer_filetype = vim.api.nvim_get_option_value("filetype", { buf = buffer_number })

			if buffer_filetype ~= "alpha" then
				buffer_delete(buffer_number, force)
				vim.cmd([[redraw!]])
			end

			M.buffer_delete_repeat()
		end

		function M.buffer_delete_repeat()
			local char = vim.fn.getcharstr()

			if char == "d" then
				M.buffer_delete(vim.fn.bufnr())
			elseif char == "D" then
				M.buffer_delete(vim.fn.bufnr(), true)
			elseif char ~= nil then
				vim.api.nvim_feedkeys(vim.keycode(char), "m", true)
			end
		end

		M.buffer_delete(force)
	end
end

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
		optional = true,
		opts = {
			options = {
				always_show_bufferline = true,
				truncate_names = false,
				indicator = { icon = "▌", style = "icon" },
				sort_by = "relative_directory",
				separator_style = { "▏", "" },
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

		config = function(_, opts)
			local catppuccin_bufferline = require("catppuccin.groups.integrations.bufferline")
			local bufferline_groups = require("bufferline.groups")

			table.insert(opts.options.groups, bufferline_groups.builtin.pinned:with({ icon = "" }))
			table.insert(opts.options.groups, bufferline_groups.builtin.ungrouped)

			opts.highlights = catppuccin_bufferline.get()
			require("bufferline").setup(opts)
		end,

		keys = {
			{ "<leader>bg", "<cmd>BufferLinePick<cr>", mode = { "n", "v", "t" }, desc = "Pick Buffer" },
		},
	},

	{
		"famiu/bufdelete.nvim",
		optional = true,
		dependencies = {
			{
				"akinsho/bufferline.nvim",
				optional = true,
				opts = {
					options = {
						close_command = buffer_delete,
						right_mouse_command = buffer_delete,
					},
				},
			},
		},

		keys = {
			{ "<leader>bd", buffer_delete_create(), desc = "Delete buffer" },
			{ "<leader>bD", buffer_delete_create(true), desc = "Delete buffer (force)" },
			{ "<leader>bm[", buffer_move_create("prev"), desc = "Move buffer (prev)" },
			{ "<leader>bm]", buffer_move_create("next"), desc = "Move buffer (next)" },
		},
	},

	{
		"tiagovla/scope.nvim",
		optional = true,
		config = true,
		keys = {
			{
				"<leader>b<tab>",
				[[<cmd>lua require("scope.core").move_current_buf({})<cr>]],
				desc = "Move buffer",
			},
		},
	},
}

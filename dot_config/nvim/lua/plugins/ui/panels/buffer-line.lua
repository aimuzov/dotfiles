local buffer_delete = function(bufnr, force)
	local buf_delete = require("bufdelete").bufdelete
	local buf_modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })

	if force or not buf_modified then
		buf_delete(bufnr, force)
		return
	end

	local buf_name = vim.api.nvim_buf_get_name(bufnr)
	local message = buf_name == "" and "Save changes" or ("Save changes to %q?"):format(buf_name)
	local choice = vim.fn.confirm(message, "&Yep\n&Nop")

	if choice == 1 then -- Yes
		vim.cmd.write()
		buf_delete(bufnr)
	elseif choice == 2 then -- No
		buf_delete(bufnr, true)
	end
end

local buf_move_create = function(dir)
	local cmd = dir == "next" and "BufferLineMoveNext" or "BufferLineMovePrev"
	local char = dir == "next" and "]" or "["

	return function()
		vim.cmd(cmd)

		local function repeat_me()
			local char_current = vim.fn.getcharstr()

			if char_current == char then
				vim.cmd(cmd)
				repeat_me()
			elseif char ~= nil then
				vim.api.nvim_feedkeys(vim.keycode(char), "m", true)
			end
		end

		repeat_me()
	end
end

return {
	{
		"akinsho/bufferline.nvim",
		optional = true,
		lazy = false,
		opts = {
			options = {
				always_show_bufferline = true,
				truncate_names = false,
				indicator = { icon = "▌", style = "icon" },
				sort_by = "relative_directory",
				separator_style = { "▏", "" },
				left_trunc_marker = "",
				right_trunc_marker = "",
				modified_icon = "",
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

					if ft == "" or ft == "alpha" then
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
			{
				"<leader>bd",
				function()
					local buf_id = vim.fn.bufnr()
					local buf_filetype = vim.api.nvim_buf_get_option(buf_id, "filetype")

					if buf_filetype == "alpha" then
						return
					end

					buffer_delete(buf_id)
				end,
				desc = "Delete buffer",
			},
			{
				"<leader>bD",
				function()
					local buf_id = vim.fn.bufnr()
					buffer_delete(buf_id, true)
				end,
				desc = "Delete buffer (force)",
			},
			{ "<leader>bm[", buf_move_create("prev"), desc = "Move buffer (prev)" },
			{ "<leader>bm]", buf_move_create("next"), desc = "Move buffer (next)" },
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

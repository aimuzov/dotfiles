local buffer_delete = function(buffer_number, force)
	if buffer_number == nil then
		return
	end

	local bufdelete = require("mini.bufremove").delete
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
			local char = require("util").char_get()

			if char == "d" then
				M.buffer_delete(vim.fn.bufnr())
			elseif char == "D" then
				M.buffer_delete(vim.fn.bufnr(), true)
			elseif char ~= nil then
				vim.api.nvim_feedkeys(vim.keycode(char), "m", true)
			end
		end

		M.buffer_delete(vim.fn.bufnr(), force)
	end
end

return {
	{
		"echasnovski/mini.bufremove",

		keys = {
			{ "<leader>bd", buffer_delete_create(), desc = "Delete buffer" },
			{ "<leader>bD", buffer_delete_create(true), desc = "Delete buffer (force)" },
		},
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = { "echasnovski/mini.bufremove" },
		optional = true,

		opts = {
			options = {
				close_command = buffer_delete,
				right_mouse_command = buffer_delete,
			},
		},
	},
}

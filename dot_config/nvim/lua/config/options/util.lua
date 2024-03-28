local M = {}

function M.langmap_create()
	local function escape(str)
		local escape_chars = [[;,."|\]]
		return vim.fn.escape(str, escape_chars)
	end

	local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
	local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
	local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
	local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

	local langmap = vim.fn.join({
		escape(ru) .. ";" .. escape(en),
		escape(ru_shift) .. ";" .. escape(en_shift),
	}, ",")

	return langmap
end

function M.options_apply(options)
	for opt_name, opt_value in pairs(options) do
		local ok, _ = pcall(vim.api.nvim_get_option_info2, opt_name, {})
		if ok then
			vim.opt[opt_name] = opt_value
		else
			vim.notify("Option " .. opt_name .. " is not supported", vim.log.levels.WARN)
		end
	end
end

function M.mouse_context_menu_fix()
	vim.cmd.aunmenu({ "PopUp.How-to\\ disable\\ mouse" })
	vim.cmd.aunmenu({ "PopUp.-1-" })
end

return M

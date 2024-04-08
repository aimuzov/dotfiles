return {
	"stevearc/conform.nvim",
	optional = true,
	opts = function()
		require("conform").formatters.stylelint = function(bufnr)
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
			local prepend_args = filetype == "svelte" and { "--custom-syntax", "postcss-html" } or {}
			local command = require("conform.util").find_executable({ "node_modules/.bin/stylelint" }, "stylelint")

			return {
				command = command,
				prepend_args = prepend_args,
			}
		end
	end,
}

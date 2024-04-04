return {
	"LazyVim/LazyVim",
	opts = function()
		for severity, icon in pairs(LazyVim.config.icons.diagnostics) do
			local name = "DiagnosticSign" .. severity
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end
	end,
}

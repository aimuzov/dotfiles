return {
	"LazyVim/LazyVim",
	opts = function()
		vim.api.nvim_create_autocmd("TermOpen", {
			desc = "Disable line numbers",
			callback = function()
				vim.opt_local.number = false
				vim.opt_local.relativenumber = false
			end,
		})
	end,
}

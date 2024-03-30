return {
	"brenton-leighton/multiple-cursors.nvim",
	opts = {
		pre_hook = function()
			vim.opt.cursorline = false
			vim.g.minipairs_disable = true
			vim.cmd("NoMatchParen")
		end,
		post_hook = function()
			vim.opt.cursorline = true
			vim.g.minipairs_disable = false
			vim.cmd("DoMatchParen")
		end,
	},
	keys = {
		{ "<c-n>", "<cmd>MultipleCursorsAddJumpNextMatch<cr>", mode = { "n", "x" } },
	},
}

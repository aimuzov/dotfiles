return {
	{
		"LazyVim/LazyVim",
		opts = function()
			vim.opt.fillchars:append({
				horiz = "━",
				horizdown = "┳",
				horizup = "┻",
				vert = "┃",
				verthoriz = "╋",
				vertleft = "┫",
				vertright = "┣",
			})
		end,
	},
}

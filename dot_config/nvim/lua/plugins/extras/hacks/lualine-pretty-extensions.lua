return {
	"nvim-lualine/lualine.nvim",
	optional = true,

	opts = function()
		-- stylua: ignore start
		require("lualine.extensions.lazy").sections.lualine_a =		{ function() return "󰒲  lazy " end }
		require("lualine.extensions.mason").sections.lualine_a =	{ function() return " mason " end }

		require("lualine.extensions.fugitive").sections.lualine_a =	{ function() return "  git  " end }
		require("lualine.extensions.fugitive").sections.lualine_b =	{ function() return " " .. vim.fn.FugitiveHead() end }

		require("lualine.extensions.neo-tree").sections.lualine_a =	{ function() return "󱉭  root " end }
		require("lualine.extensions.neo-tree").sections.lualine_b =	{ function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':~') end }
		-- stylua: ignore end
	end,
}

local winbar_filetype = {
	{
		"filetype",
		icon_only = true,
		separator = "",
		padding = { left = 3, right = 1 },
		color = { bg = "none" },
	},

	{
		LazyVim.lualine.pretty_path(),
		color = { bg = "none", gui = "bold" },
	},
}

local disabled_filetypes = {
	"aerial",
	"alpha",
	"dap-repl",
	"dapui_breakpoints",
	"dapui_console",
	"dapui_scopes",
	"dapui_stacks",
	"dapui_watches",
	"DiffviewFiles",
	"gitlab",
	"neo-tree",
	"neotest-summary",
	"noice",
	"qf",
	"spectre_panel",
	"lazyterm",
	"Trouble",
}

return {
	"nvim-lualine/lualine.nvim",

	opts = function(_, opts)
		opts.options.disabled_filetypes.winbar = disabled_filetypes
		opts.winbar = { lualine_c = winbar_filetype }
		opts.inactive_winbar = { lualine_c = winbar_filetype }
	end,
}

local kind_filter = {
	-- stylua: ignore start
	default = {
		"Array", "Boolean", "Class", "Color", "Control", "Collapsed",
		"Constant", "Constructor", "Enum", "EnumMember", "Event",
		"Field", "File", "Folder", "Function", "Interface",
		"Key", "Keyword", "Method", "Module", "Namespace",
		"Null", "Number", "Object", "Operator", "Package",
		"Property", "Reference", "Snippet", "String",
		"Struct", "Text", "TypeParameter", "Unit",
		"Value", "Variable",
	},
	-- stylua: ignore end
}

return {
	{
		"LazyVim/LazyVim",
		import = "lazyvim.plugins",

		dependencies = {
			{
				"folke/which-key.nvim",
				opts = { defaults = { ["<leader>l"] = { name = "+lazy" } } },
			},
		},

		opts = {
			kind_filter = kind_filter,
			news = { lazyvim = true, neovim = true },
		},

		keys = {
			{ "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" } },
			{ "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "Lazy extras" } },
		},
	},

	{
		"LazyVim/LazyVim",
		opts = function(_, opts)
			opts.colorscheme = require("util").colorscheme_get_name()
		end,
	},
}

local colorscheme = require("util.other").get_colorscheme()

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
		opts = {
			colorscheme = colorscheme,
			kind_filter = kind_filter,
		},
	},
}

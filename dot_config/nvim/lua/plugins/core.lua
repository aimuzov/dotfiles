local colorscheme = require("util").colorscheme_get_name()

local function override_terminal_open()
	vim.g.lazygit_config = false

	local open_original = LazyVim.terminal.open

	LazyVim.terminal.open = function(cmd, opts)
		opts = vim.tbl_deep_extend("force", opts or {}, {
			backdrop = 100,
			esc_esc = false,
			ctrl_hjkl = false,
			size = { width = 0.83, height = 0.72 },
			margin = { top = 1, bottom = 0 },
			zindex = 60,
		})

		if cmd ~= nil and cmd[1] == "lazygit" then
			local theme = require("util").os_theme_is_dark() and "dark" or "light"
			local cfg_dir = vim.fn.getenv("HOME") .. "/.config/lazygit"

			opts = vim.tbl_deep_extend("force", opts or {}, {
				border = "none",
				env = { ["LG_CONFIG_FILE"] = cfg_dir .. "/config.yml," .. cfg_dir .. "/theme-" .. theme .. ".yml" },
				size = { height = 1, width = 1 },
				margin = { top = 0, bottom = 1 },
			})
		end

		open_original(cmd, opts)
	end
end

local function override_keys_to_string()
	local Keys = require("lazy.core.handler.keys")
	local to_string_original = Keys.to_string

	Keys.to_string = function(keys)
		local result_raw = to_string_original(keys)
		local result_pretty = result_raw
			:gsub("<leader>", "󱁐")
			:gsub("%(v%)", "󰬝")
			:gsub("%(i%)", "󰬐")
			:gsub("%(x%)", "󰬟")
			:gsub("%(t%)", "󰬛")

		return result_pretty
	end
end

local function override_lualine_pretty_path()
	LazyVim.lualine.pretty_path = function(opts)
		opts = vim.tbl_extend("force", {
			relative = "cwd",
			modified_hl = "Constant",
		}, opts or {})

		return function(self)
			local path = vim.fn.expand("%:p") --[[@as string]]

			if path == "" then
				return ""
			end

			local root = LazyVim.root.get({ normalize = true })
			local cwd = LazyVim.root.cwd()

			if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
				path = path:sub(#cwd + 2)
			else
				path = path:sub(#root + 2)
			end

			local sep = "󰿟"
			local parts = vim.split(path, "[\\/]")

			if #parts > 4 then
				parts = { "⋯", parts[#parts - 2], parts[#parts - 1], parts[#parts] }
			end

			if opts.modified_hl and vim.bo.modified then
				parts[#parts] = LazyVim.lualine.format(self, parts[#parts], opts.modified_hl)
			end

			return table.concat(parts, sep)
		end
	end
end

local function override()
	override_keys_to_string()
	override_lualine_pretty_path()
	override_terminal_open()
end

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
		init = override,

		dependencies = {
			{
				"folke/which-key.nvim",
				opts = { defaults = { ["<leader>l"] = { name = "+lazy" } } },
			},
		},

		opts = {
			colorscheme = colorscheme,
			kind_filter = kind_filter,
			icons = { misc = { dots = "" } },
		},

		keys = {
			{ "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" } },
			{ "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "Lazy extras" } },
		},
	},
}

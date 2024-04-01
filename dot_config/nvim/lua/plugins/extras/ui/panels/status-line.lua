local mode_icon_map = {
	["NORMAL"] = "󰰓",
	["O-PENDING"] = "",
	["VISUAL"] = "󰰫",
	["V-LINE"] = "󰰬",
	["V-BLOCK"] = "󰰪",
	["V-REPLACE"] = "󰬝",
	["SELECT"] = "󰰢",
	["S-LINE"] = "󰰣",
	["S-BLOCK"] = "󰰡",
	["INSERT"] = "󰰄",
	["COMMAND"] = "󰯲",
	["EX"] = "󰰱",
	["REPLACE"] = "󰰟",
	["MORE"] = "󰰐",
	["CONFIRM"] = "󰯳",
	["SHELL"] = "󰰡",
	["TERMINAL"] = "󰰤",
}

return {
	{
		"nvim-lualine/lualine.nvim",

		opts = function(_, opts)
			opts.options.component_separators = { left = "", right = "" }
			opts.options.section_separators = { left = "", right = "" }
			opts.options.disabled_filetypes.statusline = {}

			opts.sections.lualine_a = {
				{
					function()
						local mode_name_upper = require("lualine.utils.mode").get_mode()
						local mode_name_lower = mode_name_upper:lower()
						local mode_icon_raw = mode_icon_map[mode_name_upper]
						local mode_icon_safety = mode_icon_raw == nil and "" or mode_icon_raw

						return mode_icon_safety .. " " .. mode_name_lower
					end,
				},
			}

			opts.sections.lualine_b = { { "branch", icon = "" } }

			opts.sections.lualine_y = {
				{ "location", padding = { left = 1, right = 1 } },
				{
					function()
						local current_line = vim.fn.line(".")
						local total_lines = vim.fn.line("$")
						local chars = { "", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥" }
						local line_ratio = current_line / total_lines
						local index = math.ceil(line_ratio * #chars)

						return chars[index]
					end,
					separator = " ",
					padding = { left = 1, right = 1 },
				},
			}

			opts.sections.lualine_z = {}
			opts.sections.lualine_x[1].color = nil

			return opts
		end,

		config = function(_, opts)
			opts.sections.lualine_c[5] = { "aerial", sep = "  ", sep_icon = "", sep_highlight = "AerialGuide1" }

			opts.sections.lualine_c = {
				opts.sections.lualine_c[1],
				opts.sections.lualine_c[5],
			}

			require("lualine").setup(opts)
		end,
	},

	{
		"mason.nvim",
		optional = true,
		dependencies = {
			"nvim-lualine/lualine.nvim",
			opts = function(_, opts)
				table.insert(opts.extensions, "mason")
			end,
		},
	},

	{
		"tpope/vim-fugitive",
		optional = true,
		dependencies = {
			"nvim-lualine/lualine.nvim",
			opts = function(_, opts)
				table.insert(opts.extensions, "fugitive")
			end,
		},
	},
}

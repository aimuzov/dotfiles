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
		optional = true,
		dependencies = { "stevearc/aerial.nvim" },
		opts = function(_, opts)
			local utils = require("lualine.utils.mode")

			opts.options.theme = "catppuccin"

			opts.options.component_separators = { left = "", right = "" }
			opts.options.section_separators = { left = "▒░", right = "░▒" }
			opts.options.disabled_filetypes.statusline = {}

			require("lualine.extensions.lazy").sections.lualine_a = {
				function()
					return "󰰍 lazy "
				end,
			}

			table.insert(opts.extensions, "toggleterm")
			table.insert(opts.extensions, "man")
			table.insert(opts.extensions, "trouble")
			table.insert(opts.extensions, "overseer")

			opts.sections.lualine_a = {
				{
					function()
						local mode_name_upper = utils.get_mode()
						local mode_name_lower = mode_name_upper:lower()
						local mode_icon_raw = mode_icon_map[mode_name_upper]
						local mode_icon_safety = mode_icon_raw == nil and "" or mode_icon_raw

						return mode_icon_safety .. " " .. mode_name_lower
					end,
				},
			}

			opts.sections.lualine_b = { { "branch", icon = "" } }
			opts.sections.lualine_c = { { "aerial", sep = "  ", sep_icon = "", sep_highlight = "AerialGuide1" } }

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
	},
}

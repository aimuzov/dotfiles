local function header_colorize(header)
	local lines = {}

	for i, chars in pairs(header) do
		local line = {
			type = "text",
			val = chars,
			opts = {
				hl = "AlphaHeader" .. i,
				position = "center",
			},
		}

		table.insert(lines, line)
	end

	return lines
end

local function button(sc, icon, text, keybind)
	return {
		type = "button",
		val = text,
		opts = {
			position = "center",
			shortcut = "▌ " .. icon .. " ▐",
			cursor = 40,
			keymap = { "n", sc, keybind, {} },
			width = 42,
			align_shortcut = "right",
			hl = "AlphaButtons",
			hl_shortcut = "AlphaShortcut",
		},
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
			vim.api.nvim_feedkeys(key, "t", false)
		end,
	}
end

local buttons_wrap = function(border)
	return {
		type = "text",
		val = string.rep(" ", 37) .. border,
		opts = { position = "center", hl = "AlphaShortcutBorder" },
	}
end

local header_text = {
	[[⌜                                                                          r1      team ↗  ⌝]],
	[[ ███████╗   ██████╗  ████████╗ ██╗   ██╗ ███████╗   ███████╗   ██████╗  ███████╗  ███████╗  ]],
	[[ ██╔═══██╗ ██╔═══██╗ ██╔═════╝ ██║   ██║ ██╔═══██╗ ██╔════██╗ ██╔═══██╗ ██╔═══██╗ ██╔═══██╗ ]],
	[[ ██║   ██║ ████████║ ████████╗ ████████║ ███████╔╝ ██║    ██║ ████████║ ███████╔╝ ██║   ██║ ]],
	[[ ██║   ██║ ██╔═══██║ ╚═════██║ ██╔═══██║ ██╔═══██╗ ██║    ██║ ██╔═══██║ ██╔═══██╗ ██║   ██║ ]],
	[[ ███████╔╝ ██║   ██║ ████████║ ██║   ██║ ███████╔╝ ╚███████╔╝ ██║   ██║ ██║   ██║ ███████╔╝ ]],
	[[ ╚══════╝  ╚═╝   ╚═╝ ╚═══════╝ ╚═╝   ╚═╝ ╚══════╝   ╚══════╝  ╚═╝   ╚═╝ ╚═╝   ╚═╝ ╚══════╝  ]],
	[[⌞ lazyvim 󰌌  ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆  by Aleksey Imuzov 󱟄 ⌟]],
}

local section = {
	header = {
		type = "group",
		opts = { position = "center" },
		val = header_colorize(header_text),
	},
	buttons = {
		type = "group",
		opts = { lh = "AlphaButtons" },
		val = {
			button("n", "󰫻", "  New file", "<cmd>ene <bar> startinsert<cr>"),
			button("l", "󱎦", "󰒲  Lazy", "<cmd>Lazy<cr>"),
			button("q", "󰫾", "  Quit", "<cmd>qa<cr>"),
		},
	},
	footer = {
		type = "text",
		opts = { position = "center", hl = "AlphaFooter" },
		val = "",
	},
}

return {
	{
		"goolord/alpha-nvim",
		optional = true,
		opts = function(_, opts)
			local lazy_util = require("lazyvim.util")

			opts.section = section
			opts.opts = {
				layout = {
					{ type = "padding", val = 3 },
					section.header,
					{ type = "padding", val = 1 },
					buttons_wrap("▁▁▁▁▁"),
					section.buttons,
					buttons_wrap("▔▔▔▔▔"),
					{ type = "padding", val = 1 },
					section.footer,
				},
			}

			if lazy_util.has("telescope.nvim") then
				table.insert(
					opts.section.buttons.val,
					#opts.section.buttons.val - 1,
					button("f", "󰫳", "  Find file", "<cmd>Telescope find_files<cr>")
				)

				table.insert(
					opts.section.buttons.val,
					#opts.section.buttons.val - 1,
					button("r", "󰫿", "  Recent files", "<cmd>Telescope oldfiles<cr>")
				)

				table.insert(
					opts.section.buttons.val,
					#opts.section.buttons.val - 1,
					button("g", "󰫴", "  Find text", "<cmd>Telescope live_grep<cr>")
				)
			end

			if lazy_util.has("persistence.nvim") then
				table.insert(
					opts.section.buttons.val,
					#opts.section.buttons.val - 1,
					button("s", "󰬀", "  Restore Session", [[<cmd>lua require("persistence").load()<cr>]])
				)
			end

			vim.api.nvim_create_autocmd("User", {
				once = true,
				pattern = "AlphaReady",
				callback = require("util").alpha_header_animate,
			})

			return opts
		end,
	},
}

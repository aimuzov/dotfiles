local function lazyvim_override_keys_to_string()
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

local function lazyvim_override_open_terminal()
	local LazyvimUtil = require("lazyvim.util")
	local open_original = LazyvimUtil.terminal.open

	LazyvimUtil.terminal.open = function(cmd, opts)
		if cmd ~= nil and cmd[1] == "lazygit" then
			local theme = require("util").os_theme_is_dark() and "dark" or "light"
			local cfg_dir = vim.fn.getenv("HOME") .. "/.config/lazygit"

			open_original({ "lazygit" }, {
				cwd = LazyvimUtil.root.get(),
				border = "none",
				env = { ["LG_CONFIG_FILE"] = cfg_dir .. "/config.yml," .. cfg_dir .. "/theme-" .. theme .. ".yml" },
				zindex = 60,
				size = { height = 1, width = 1 },
				esc_esc = false,
				margin = { top = 1, bottom = 1 },
				ctrl_hjkl = false,
			})

			return
		end

		open_original(cmd, opts)
	end
end

local function lazyvim_override_lualine_pretty_path()
	local LazyvimUtil = require("lazyvim.util")

	LazyvimUtil.lualine.pretty_path = function(opts)
		opts = vim.tbl_extend("force", {
			relative = "cwd",
			modified_hl = "Constant",
		}, opts or {})

		return function(self)
			local path = vim.fn.expand("%:p") --[[@as string]]

			if path == "" then
				return ""
			end

			local root = LazyvimUtil.root.get({ normalize = true })
			local cwd = LazyvimUtil.root.cwd()

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
				parts[#parts] = LazyvimUtil.lualine.format(self, parts[#parts], opts.modified_hl)
			end

			return table.concat(parts, sep)
		end
	end
end

local function mouse_remove_context_actions()
	vim.cmd.aunmenu({ "PopUp.How-to\\ disable\\ mouse" })
	vim.cmd.aunmenu({ "PopUp.-1-" })
end

lazyvim_override_keys_to_string()
lazyvim_override_open_terminal()
lazyvim_override_lualine_pretty_path()
mouse_remove_context_actions()

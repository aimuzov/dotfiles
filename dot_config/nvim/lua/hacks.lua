local override_lazy_keys_to_string = function()
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

local override_lazy_open = function()
	local Util = require("lazyvim.util")
	local open_original = Util.terminal.open

	Util.terminal.open = function(cmd, opts)
		if cmd[1] == "lazygit" then
			local UtilOther = require("util.other")
			local theme = UtilOther.is_os_theme_dark() and "dark" or "light"
			local cfg_dir = vim.fn.getenv("HOME") .. "/.config/lazygit"

			open_original({ "lazygit" }, {
				cwd = Util.root.get(),
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

local override_lazy_lualine_pretty_path = function()
	local Util = require("lazyvim.util")

	Util.lualine.pretty_path = function(opts)
		opts = vim.tbl_extend("force", {
			relative = "cwd",
			modified_hl = "Constant",
		}, opts or {})

		return function(self)
			local path = vim.fn.expand("%:p") --[[@as string]]

			if path == "" then
				return ""
			end

			local root = Util.root.get({ normalize = true })
			local cwd = Util.root.cwd()

			if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
				path = path:sub(#cwd + 2)
			else
				path = path:sub(#root + 2)
			end

			local sep = "󰿟" -- package.config:sub(1, 1)
			local parts = vim.split(path, "[\\/]")

			if #parts > 4 then
				parts = { "⋯", parts[#parts - 2], parts[#parts - 1], parts[#parts] }
			end

			if opts.modified_hl and vim.bo.modified then
				parts[#parts] = Util.lualine.format(self, parts[#parts], opts.modified_hl)
			end

			return table.concat(parts, sep)
		end
	end
end

local remove_context_actions = function()
	vim.cmd.aunmenu({ "PopUp.How-to\\ disable\\ mouse" })
	vim.cmd.aunmenu({ "PopUp.-1-" })
end

override_lazy_keys_to_string()
override_lazy_open()
override_lazy_lualine_pretty_path()
remove_context_actions()

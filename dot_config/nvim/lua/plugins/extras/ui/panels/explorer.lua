local pretty_path = function(str, substr)
	return "~" .. str:sub(substr:len())
end

local node_close_or_goto_parent = function(state)
	local node = state.tree:get_node()

	if (node.type == "directory" or node:has_children()) and node:is_expanded() then
		state.commands.toggle_node(state)
	else
		require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
	end
end

local node_open_or_file_open = function(state)
	local node = state.tree:get_node()

	if node.type == "directory" or node:has_children() then
		if not node:is_expanded() then
			state.commands.toggle_node(state)
		else
			require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
		end
	else
		state.commands.open(state)
	end
end

local copy_selector = function(state)
	local node = state.tree:get_node()
	local filepath = node:get_id()
	local filename = node.name
	local messages = { { "\nChoose to copy to clipboard:\n", "Normal" } }
	local modify = vim.fn.fnamemodify

	local results = {
		e = { val = modify(filename, ":e"), msg = "Extension only" },
		f = { val = filename, msg = "Filename" },
		F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
		h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
		p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
		P = { val = filepath, msg = "Absolute path" },
	}

	for i, result in pairs(results) do
		if result.val and result.val ~= "" then
			vim.list_extend(messages, {
				{ ("%s."):format(i), "Identifier" },
				{ (" %s: "):format(result.msg) },
				{ result.val, "String" },
				{ "\n" },
			})
		end
	end

	vim.api.nvim_echo(messages, false, {})

	local char = vim.fn.getcharstr()
	local result = results[char]

	if result and result.val and result.val ~= "" then
		vim.notify("Copied: " .. result.val)
		vim.fn.setreg("+", result.val)
	end
end

local system_open = function(state)
	local node = state.tree:get_node()
	local path = node:get_id()

	vim.fn.jobstart({ "open", path }, { detach = true })
end

local delete = function(state)
	local inputs = require("neo-tree.ui.inputs")
	local path = state.tree:get_node().path
	local path_relative = pretty_path(path, vim.fn.getcwd() .. "/")
	local msg = 'Confirm delete "' .. path_relative .. '"'

	inputs.confirm(msg, function(confirmed)
		if not confirmed then
			return
		end

		vim.fn.system({ "trash", vim.fn.fnameescape(path) })
		pcall(require("mini.bufremove").delete, path, true)
		require("neo-tree.sources.manager").refresh(state.name)
	end)
end

local delete_visual = function(state, selected_nodes)
	local inputs = require("neo-tree.ui.inputs")

	local get_table_len = function(tbl)
		local len = 0
		for _ in pairs(tbl) do
			len = len + 1
		end
		return len
	end

	local count = get_table_len(selected_nodes)

	local msg = "Confirm delete " .. count .. " files"

	inputs.confirm(msg, function(confirmed)
		if not confirmed then
			return
		end

		for _, node in ipairs(selected_nodes) do
			pcall(require("mini.bufremove").delete, node.path, true)
			vim.fn.system({ "trash", vim.fn.fnameescape(node.path) })
		end

		require("neo-tree.sources.manager").refresh(state.name)
	end)
end

return {
	{
		"nvim-neo-tree/neo-tree.nvim",

		keys = {
			{
				"<c-e>",
				[[<cmd>lua require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })<cr>]],
				mode = { "n", "v", "t" },
				desc = "Toggle explorer",
			},
		},

		opts = {
			show_scrolled_off_parent_node = true,
			use_popups_for_input = true,

			default_component_configs = {
				indent = {
					indent_marker = "│",
					last_indent_marker = "╰",
				},
				icon = { folder_empty = "󰉖", default = "" },
				modified = { symbol = "" },
				git_status = {
					symbols = {
						added = "",
						modified = "",
						deleted = "󰚃",
						renamed = "󰛿",
						untracked = "○",
						ignored = "◌",
						unstaged = "○",
						staged = "●",
						conflict = "◎",
					},
				},
				file_size = { required_width = 48 },
				last_modified = { required_width = 72 },
			},

			buffers = {
				display_name = "  󰈚  BUF",
				show_unloaded = true,
			},

			filesystem = {
				display_name = " 󰉓   DIR",

				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					never_show = { ".DS_Store", ".git" },
					hide_by_pattern = { ".*" },
				},

				commands = {
					delete = delete,
					delete_visual = delete_visual,
				},

				window = {
					mappings = {
						["<c-s-h>"] = "toggle_hidden",
					},

					fuzzy_finder_mappings = {
						["<c-j>"] = "move_cursor_down",
						["<c-k>"] = "move_cursor_up",
					},
				},
			},

			git_status = {
				display_name = "  󰊢  GIT",
			},

			sources = {
				"filesystem",
				"buffers",
				"git_status",
			},

			source_selector = {
				winbar = true,
				sources = {
					{ source = "filesystem" },
					{ source = "buffers" },
					{ source = "git_status" },
				},
			},

			commands = {
				node_open_or_file_open = node_open_or_file_open,
				node_close_or_goto_parent = node_close_or_goto_parent,
				copy_selector = copy_selector,
				system_open = system_open,
			},

			window = {
				mappings = {
					["<space>"] = false,
					["h"] = "node_close_or_goto_parent",
					["l"] = "node_open_or_file_open",
					["Y"] = "copy_selector",
					["O"] = "system_open",
					["<s-h>"] = "prev_source",
					["<s-l>"] = "next_source",
				},
			},

			event_handlers = {
				{
					event = "neo_tree_popup_input_ready",
					handler = function()
						vim.cmd("stopinsert")
					end,
				},
			},
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",

		opts = function()
			local renderer = require("neo-tree.ui.renderer")
			local manager = require("neo-tree.sources.manager")

			vim.api.nvim_create_autocmd({ "TermOpen", "TermClose" }, {
				callback = function()
					if renderer.window_exists(manager.get_state("buffers")) then
						manager.refresh("buffers")
					end
				end,
			})
		end,
	},

	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = true,
	},
}

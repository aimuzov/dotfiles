local function show_hidden()
	local action_state = require("telescope.actions.state")
	local line = action_state.get_current_line()
	LazyVim.telescope("find_files", { hidden = true, default_text = line })()
end

local function open_selected(prompt_bufnr)
	local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
	local multi = picker:get_multi_selection()
	if not vim.tbl_isempty(multi) then
		require("telescope.actions").close(prompt_bufnr)
		for _, j in pairs(multi) do
			if j.path ~= nil then
				vim.cmd(string.format("%s %s", "edit", j.path))
			end
		end
	else
		require("telescope.actions").select_default(prompt_bufnr)
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "tiagovla/scope.nvim" },
		},

		opts = {
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
					height = 0.95,
					width = 0.8,
					preview_cutoff = 20,
				},
				mappings = {
					i = {
						["<c-h>"] = show_hidden,
						["<cr>"] = open_selected,
					},
				},
			},

			extensions = {
				file_browser = {
					path = "%:p:h",
					select_buffer = true,
					display_stat = { size = true, date = true },
				},

				live_grep_args = {
					path_display = { "smart" },
					disable_coordinates = true,
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
		},

		keys = {
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers (per tab)" },
			{ "<leader>fB", "<cmd>Telescope scope buffers<cr>", desc = "Buffers (all)" },
			{ "<leader>fd", "<cmd>Telescope file_browser<cr>", desc = "Buffers (all)" },
			{
				"<leader>fc",
				"<cmd>Telescope find_files cwd=" .. vim.fn.getenv("DOTFILES_SRC_PATH") .. "<cr>",
				desc = "Find dotfile",
			},
			{
				"<leader>sg",
				[[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>]],
				desc = "Grep (with args)",
			},
		},

		config = function(_, opts)
			require("telescope").setup(opts)

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("scope")
			require("telescope").load_extension("live_grep_args")
		end,
	},

	{
		"sindrets/diffview.nvim",
		opts = {
			file_panel = {
				win_config = { width = 40 },
			},
		},
	},

	{
		"dnlhc/glance.nvim",

		opts = {
			theme = { enable = false },
			border = {
				enable = true,
				top_char = "▁",
				bottom_char = "▔",
			},
			hooks = {
				before_open = function(results, open, jump)
					if #results == 1 then
						jump(results[1])
					else
						open(results)
					end
				end,
			},
		},

		keys = {
			{ "<leader>gd", "<CMD>Glance definitions<CR>", desc = "" },
			{ "<leader>gr", "<CMD>Glance references<CR>", desc = "" },
			{ "<leader>gy", "<CMD>Glance type_definitions<CR>", desc = "" },
			{ "<leader>gm", "<CMD>Glance implementations<CR>", desc = "" },
		},
	},
}

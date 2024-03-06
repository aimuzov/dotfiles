local nvim_cfg_src_path = vim.fn.getenv("DOTFILES_SRC_PATH") .. "/dot_config/nvim"

local function show_hidden()
	local action_state = require("telescope.actions.state")
	local line = action_state.get_current_line()
	require("lazyvim.util").telescope("find_files", { hidden = true, default_text = line })()
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
				mappings = {
					i = {
						["<c-h>"] = show_hidden,
						["<cr>"] = open_selected,
					},
				},
			},

			pickers = {
				find_files = { theme = "dropdown", previewer = true },
				git_files = { theme = "dropdown", previewer = true },
				oldfiles = { theme = "dropdown", previewer = true },
				buffers = { theme = "dropdown", previewer = true },
				highlights = { theme = "dropdown", previewer = true },

				lsp_document_symbols = { theme = "dropdown", previewer = true },
				lsp_dynamic_workspace_symbols = { theme = "dropdown", previewer = true },

				lsp_references = {
					theme = "dropdown",
					previewer = true,
					show_line = false,
					path_display = { "smart" },
					jump_type = "vsplit",
				},

				live_grep = {
					theme = "dropdown",
					path_display = { "tail" },
					disable_coordinates = true,
					layout_config = { width = 0.75, height = 0.25 },
					previewer = true,
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},

			extensions = {
				file_browser = {
					theme = "dropdown",
					path = "%:p:h",
					select_buffer = true,
					display_stat = { size = true, date = true },
				},
			},
		},

		keys = {
			{ "<leader>fc", "<cmd>Telescope find_files cwd=" .. nvim_cfg_src_path .. "<cr>", desc = "Find cfg file" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers (per tab)" },
			{ "<leader>fB", "<cmd>Telescope scope buffers theme=dropdown<cr>", desc = "Buffers (all)" },
			{ "<leader>fd", "<cmd>Telescope file_browser<cr>", desc = "Buffers (all)" },
			-- stylua: ignore
			{ "<leader>sg", [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>]], desc = "Grep (with args)" },
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
		optional = true,
		opts = {
			file_panel = {
				win_config = { width = 40 },
			},
		},
	},
}

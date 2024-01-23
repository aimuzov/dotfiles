return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
			{
				"tiagovla/scope.nvim",
				init = function()
					require("telescope").load_extension("scope")
				end,
			},
		},

		opts = {
			defaults = {
				layout_strategy = "vertical",
				mappings = {
					i = {
						["<c-h>"] = function()
							local action_state = require("telescope.actions.state")
							local line = action_state.get_current_line()
							require("lazyvim.util").telescope("find_files", { hidden = true, default_text = line })()
						end,
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
		},

		keys = {
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers (per tab)" },
			{ "<leader>fB", "<cmd>Telescope scope buffers theme=dropdown<cr>", desc = "Buffers (all)" },
		},
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

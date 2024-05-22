local dotfiles_path = vim.fn.getenv("DOTFILES_SRC_PATH")
dotfiles_path = dotfiles_path == vim.NIL and "" or dotfiles_path

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
	"nvim-telescope/telescope.nvim",

	opts = {
		defaults = {
			layout_strategy = "vertical",
			layout_config = {
				height = 0.95,
				width = 0.8,
				preview_cutoff = 20,
			},
			mappings = {
				i = { ["<cr>"] = open_selected },
			},
		},
	},

	keys = {
		{
			"<leader>fc",
			"<cmd>Telescope find_files cwd=" .. dotfiles_path .. "<cr>",
			desc = "Find dotfile",
		},
	},

	config = function(_, opts)
		require("telescope").setup(opts)

		if LazyVim.has("telescope-file-browser.nvim") then
			require("telescope").load_extension("file_browser")
		end

		if LazyVim.has("telescope-fzf-native.nvim") then
			require("telescope").load_extension("fzf")
		end

		if LazyVim.has("telescope-live-grep-args.nvim") then
			require("telescope").load_extension("live_grep_args")
		end

		if LazyVim.has("scope.nvim") then
			require("telescope").load_extension("scope")
		end
	end,
}

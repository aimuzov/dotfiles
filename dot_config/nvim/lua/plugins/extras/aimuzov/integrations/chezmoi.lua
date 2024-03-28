return {
	"alker0/chezmoi.vim",

	opts = {
		use_tmp_buffer = true,
		source_dir_path = vim.fn.getenv("DOTFILES_SRC_PATH"),
	},

	config = function(_, opts)
		for key, value in pairs(opts) do
			vim.g["chezmoi#" .. key] = value
		end
	end,
}

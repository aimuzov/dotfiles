return {
	{
		"alker0/chezmoi.vim",
		optional = true,

		opts = {
			use_tmp_buffer = true,
			source_dir_path = vim.fn.getenv("HOME") .. "/projects/aimuzov/dotfiles",
		},

		config = function(_, opts)
			for key, value in pairs(opts) do
				vim.g["chezmoi#" .. key] = value
			end
		end,
	},
}

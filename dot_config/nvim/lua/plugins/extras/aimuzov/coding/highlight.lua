return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local js_max_filesize = 50 * 1024 -- 50 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

					if
						ok
						and stats
						and (stats.size > max_filesize or lang == "js" and stats.size > js_max_filesize)
					then
						return true
					end
				end,
			},
		},
	},

	{
		"RRethy/vim-illuminate",
		opts = {
			delay = 250,
			providers = { "lsp", "treesitter", "regex" },
			filetypes_denylist = { "alpha", "aerial", "markdown", "neo-tree", "toggleterm", "DiffviewFiles", "Glance" },
			min_count_to_highlight = 2,
		},
	},
}

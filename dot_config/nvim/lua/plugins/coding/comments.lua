return {
	{
		"mini.comment",
		optional = true,
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},

	{
		"kkoomen/vim-doge",
		optional = true,
		build = ":call doge#install()",
		init = function()
			vim.g.doge_javascript_settings = {
				destructuring_props = 0,
				omit_redundant_param_types = 1,
			}
		end,
	},
}

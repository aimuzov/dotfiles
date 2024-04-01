return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = true,
							},

							diagnostics = {
								globals = { "LazyVim" },
							},
						},
					},
				},
			},
		},
	},
}

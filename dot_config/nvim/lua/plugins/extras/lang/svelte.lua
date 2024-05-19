local function get_capabilities()
	local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	lsp_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
	lsp_capabilities.textDocument.completion = capabilities.textDocument.completion
end

local function notify_ts_files_changed()
	LazyVim.lsp.on_attach(function(client)
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.js", "*.ts" },
			callback = function(ctx)
				client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
			end,
		})
	end)
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		opts = {
			servers = { svelte = {} },

			setup = {
				svelte = function(_, opts)
					local lspconfig = require("lspconfig")

					opts.capabilities = get_capabilities()

					notify_ts_files_changed()
					lspconfig.svelte.setup(opts)
				end,
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "svelte", "scss" })
		end,
	},
}

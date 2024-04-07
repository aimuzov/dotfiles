local keys = {
	-- stylua: ignore start
	{ "<leader>co",		[[<cmd>lua require("vtsls").commands.organize_imports(0)<cr> ]],	desc = "Organize Imports" },
	{ "<leader>cM",		[[<cmd>lua require("vtsls").commands.add_missing_imports(0)<cr>]],	desc = "Add missing imports" },
	{ "<leader>cD",		[[<cmd>lua require("vtsls").commands.fix_all(0)<cr>]],				desc = "Fix all diagnostics" },
	{ "<leader>cLL",	[[<cmd>lua require("vtsls").commands.open_tsserver_log()<cr>]],		desc = "Open Vtsls Log" },
	{ "<leader>cR",		[[<cmd>lua require("vtsls").commands.rename_file(0)<cr>]],			desc = "Rename File" },
	{ "<leader>cu",		[[<cmd>lua require("vtsls").commands.file_references(0)<cr>]],		desc = "Show File Uses(References)" },
	-- stylua: ignore end
}

local settings = {
	vtsls = {
		experimental = {
			completion = {
				enableServerSideFuzzyMatch = true,
			},
		},
	},

	javascript = {
		format = {
			indentSize = vim.o.shiftwidth,
			convertTabsToSpaces = vim.o.expandtab,
			tabSize = vim.o.tabstop,
		},

		-- enables inline hints
		inlayHints = {
			parameterNames = { enabled = "literals" },
			parameterTypes = { enabled = true },
			variableTypes = { enabled = true },
			propertyDeclarationTypes = { enabled = true },
			functionLikeReturnTypes = { enabled = true },
			enumMemberValues = { enabled = true },
		},

		-- otherwise it would ask every time if you want to update imports, which is a bit annoying
		updateImportsOnFileMove = {
			enabled = "always",
		},

		-- cool feature, but increases ram usage
		-- referencesCodeLens = {
		--   enabled = true,
		--   showOnAllFunctions = true,
		-- },
	},

	typescript = {
		format = {
			indentSize = vim.o.shiftwidth,
			convertTabsToSpaces = vim.o.expandtab,
			tabSize = vim.o.tabstop,
		},

		updateImportsOnFileMove = {
			enabled = "always",
		},

		inlayHints = {
			parameterNames = { enabled = "literals" },
			parameterTypes = { enabled = true },
			variableTypes = { enabled = true },
			propertyDeclarationTypes = { enabled = true },
			functionLikeReturnTypes = { enabled = true },
			enumMemberValues = { enabled = true },
		},

		-- enables project wide error reporting similar to vscode
		-- tsserver = {
		--   experimental = {
		--     enableProjectDiagnostics = true,
		--   },
		-- },
	},
}

return {

	{
		"neovim/nvim-lspconfig",
		opts = function()
			-- set default server config to use nvim-vtsls one, which would allow use to use the plugin
			require("lspconfig.configs").vtsls = require("vtsls").lspconfig
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "yioneko/nvim-vtsls" },
		opts = {
			servers = {
				vtsls = {
					keys = keys,
					settings = settings,
				},
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
		end,
	},

	-- {
	-- 	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- 	optional = true,
	-- 	opts = function(_, opts)
	-- 		vim.list_extend(opts.ensure_installed, { "vtsls" })
	-- 	end,
	-- },

	-- {
	-- 	"mfussenegger/nvim-dap",
	-- 	optional = true,
	-- 	dependencies = {
	-- 		{
	-- 			"williamboman/mason.nvim",
	-- 			opts = function(_, opts)
	-- 				vim.list_extend(opts.ensure_installed, {
	-- 					"vtsls",
	-- 					"js-debug-adapter",
	-- 					"chrome-debug-adapter",
	-- 				})
	-- 			end,
	-- 		},
	-- 	},
	-- 	opts = function()
	-- 		local languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
	--
	-- 		local dap = require("dap")
	--
	-- 		dap.adapters["pwa-node"] = {
	-- 			type = "server",
	-- 			host = "localhost",
	-- 			port = "${port}",
	-- 			executable = {
	-- 				command = "js-debug-adapter",
	-- 				args = { "${port}" },
	-- 			},
	-- 		}
	--
	-- 		dap.adapters["pwa-chrome"] = {
	-- 			type = "server",
	-- 			host = "localhost",
	-- 			port = "${port}",
	-- 			executable = {
	-- 				command = "js-debug-adapter",
	-- 				args = { "${port}" },
	-- 			},
	-- 		}
	--
	-- 		-- pwa-chrome isn't working fully.
	-- 		-- https://stackoverflow.com/a/73427518/5930949
	-- 		dap.adapters["chrome"] = {
	-- 			type = "executable",
	-- 			command = "chrome-debug-adapter",
	-- 			-- host = "localhost",
	-- 			-- port = "${port}",
	-- 			-- executable = {
	-- 			--     command = "chrome-debug-adapter",
	-- 			--     -- args = { "${port}" },
	-- 			-- },
	-- 		}
	--
	-- 		require("dap.ext.vscode").load_launchjs(nil, {
	-- 			["pwa-node"] = languages,
	-- 			["node"] = languages,
	-- 			["chrome"] = languages,
	-- 			["pwa-chrome"] = languages,
	-- 		})
	--
	-- 		for _, language in ipairs(languages) do
	-- 			if dap.configurations[language] == nil then
	-- 				dap.configurations[language] = {}
	-- 			end
	--
	-- 			if language:find("javascript") then
	-- 				vim.list_extend(dap.configurations[language], {
	-- 					{
	-- 						type = "pwa-node",
	-- 						request = "launch",
	-- 						name = "Launch file (node)",
	-- 						program = "${file}",
	-- 						cwd = "${workspaceFolder}",
	-- 					},
	-- 				})
	-- 			end
	--
	-- 			if language:find("typescript") then
	-- 				vim.list_extend(dap.configurations[language], {
	-- 					{
	-- 						type = "pwa-node",
	-- 						request = "launch",
	-- 						name = "Launch file (tsx)",
	-- 						cwd = "${workspaceFolder}",
	-- 						-- NOTE: you would need to have tsx installed globally (`npm i tsx -g`)
	-- 						runtimeExecutable = "tsx",
	-- 						args = { "${file}" },
	-- 						sourceMaps = true,
	-- 						protocol = "inspector",
	-- 						skipFiles = { "<node_internals>/**", "node_modules/**" },
	-- 						resolveSourceMapLocations = {
	-- 							"${workspaceFolder}/**",
	-- 							"!**/node_modules/**",
	-- 						},
	-- 					},
	-- 				})
	-- 			end
	--
	-- 			vim.list_extend(dap.configurations[language], {
	-- 				{
	-- 					type = "pwa-node",
	-- 					request = "attach",
	-- 					name = "Attach to process",
	-- 					processId = require("dap.utils").pick_process,
	-- 					cwd = "${workspaceFolder}",
	-- 				},
	-- 			})
	-- 		end
	-- 	end,
	-- },
}

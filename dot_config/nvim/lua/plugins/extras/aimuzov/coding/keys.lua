return {
	{
		"folke/which-key.nvim",
		dependencies = { "Wansmer/langmapper.nvim" },

		opts = function(_, opts)
			local lmu = require("langmapper.utils")

			opts.triggers_blacklist = {
				o = lmu.trans_list({ ";", ".", '"', "'", "j", "k", "D", "s", "S" }),
				i = lmu.trans_list({ ";", ".", '"', "'", "j", "k", "D", "s", "S" }),
				n = lmu.trans_list({ ";", ".", '"', "'", "j", "k", "D", "s", "S" }),
				v = lmu.trans_list({ ";", ".", '"', "'", "j", "k", "D", "s", "S" }),
			}

			opts.plugins = { spelling = false }
			opts.icons = { group = " " }
			opts.layout = { spacing = 5 }
			opts.window = { winblend = 15 }
		end,

		config = function(_, opts)
			local lmu = require("langmapper.utils")
			local view = require("which-key.view")
			local execute = view.execute

			view.execute = function(prefix_i, mode, buf)
				prefix_i = lmu.translate_keycode(prefix_i, "default", "ru")
				execute(prefix_i, mode, buf)
			end

			require("which-key").setup(opts)
			require("which-key").register(opts.defaults)
		end,
	},

	{
		"Wansmer/langmapper.nvim",
		priority = 1,
		opts = {
			default_layout = [[ABCDEFGHIJKLMNOPQRSTUVWXYZ<>:"{}~abcdefghijklmnopqrstuvwxyz,.;'[]`]],

			layouts = {
				ru = {
					id = "com.apple.keylayout.Russian",
					layout = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯБЮЖЭХЪËфисвуапршолдьтщзйкыегмцчнябюжэхъё",
				},
			},
		},
		config = function(_, opts)
			local lm = require("langmapper")

			lm.setup(opts)
			lm.hack_get_keymap()
		end,
	},
}

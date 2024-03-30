return {
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			local cmp = require("cmp")

			opts.window = {
				documentation = {
					winhighlight = "FloatBorder:CmpDocFloat,NormalFloat:CmpDocFloat",
					border = { "", "", "", " ", "", "", "", " " },
				},
			}

			opts.enabled = function()
				local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })

				if buftype == "prompt" then
					return false
				end

				local context = require("cmp.config.context")

				return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
			end

			opts.sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,

					function(entry1, entry2)
						local _, entry1_under = entry1.completion_item.label:find("^_+")
						local _, entry2_under = entry2.completion_item.label:find("^_+")

						entry1_under = entry1_under or 0
						entry2_under = entry2_under or 0

						if entry1_under > entry2_under then
							return false
						elseif entry1_under < entry2_under then
							return true
						end
					end,

					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
				},
			}

			opts.sources = cmp.config.sources({
				{ name = "codeium" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
			}, {
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "buffer", keyword_length = 3 },
			})
		end,
	},
}

return {
	{
		"nvim-pack/nvim-spectre",
		optional = true,
		opts = {
			highlight = { border = "SpectreBorderCustom" },

			-- stylua: ignore start
			line_sep_start =	"┌──────────────────────────────────────────────────────────────────────────",
			result_padding =	"│   ",
			line_sep =			"└──────────────────────────────────────────────────────────────────────────",
			-- stylua: ignore end
		},
	},
}

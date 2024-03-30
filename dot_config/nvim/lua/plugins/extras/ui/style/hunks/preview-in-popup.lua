return {
	"lewis6991/gitsigns.nvim",

	opts = function(_, opts)
		local on_attach_orig = opts.on_attach
		local on_attach_modified = function(buffer)
			local keyOpts = { buffer = buffer, desc = "Preview Hunk" }
			vim.keymap.set("n", "<leader>ghP", require("gitsigns").preview_hunk, keyOpts)
			on_attach_orig(buffer)
		end

		opts.on_attach = on_attach_modified
		opts.preview_config = vim.tbl_extend("force", opts.preview_config or {}, { row = 1, col = 1 })
	end,
}

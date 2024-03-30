return {
	"lukas-reineke/virt-column.nvim",
	event = "VimEnter",
	opts = {
		char = "│",
		highlight = "IblIndent",
		virtcolumn = "+1,120",
		exclude = { filetypes = { "alpha" } },
	},
}

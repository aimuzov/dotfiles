return {
	"tpope/vim-fugitive",

	keys = {
		{ "go", "<cmd>GBrowse<cr>", desc = "Open (browser)", mode = { "n" } },
		{ "go", "<cmd>'<,'>GBrowse<cr>", desc = "Open range (browser)", mode = { "v" } },
	},
}

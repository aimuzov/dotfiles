local plugins_enabled = {
	"akinsho/git-conflict.nvim",
	"akinsho/toggleterm.nvim",
	"antosha417/nvim-lsp-file-operations",
	"famiu/bufdelete.nvim",
	"folke/edgy.nvim",
	"folke/twilight.nvim",
	"folke/zen-mode.nvim",
	"fredeeb/tardis.nvim",
	"jackMort/ChatGPT.nvim",
	"kkoomen/vim-doge",
	"lewis6991/satellite.nvim",
	"lukas-reineke/virt-column.nvim",
	"mg979/vim-visual-multi",
	"mxsdev/nvim-dap-vscode-js",
	"olrtg/nvim-emmet",
	"piersolenski/wtf.nvim",
	"s1n7ax/nvim-window-picker",
	"shumphrey/fugitive-gitlab.vim",
	"sindrets/diffview.nvim",
	"sudormrfbin/cheatsheet.nvim",
	"tiagovla/scope.nvim",
	"tpope/vim-fugitive",
	"Wansmer/langmapper.nvim",
	"Wansmer/sibling-swap.nvim",
	"Wansmer/symbol-usage.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"zeioth/garbage-day.nvim",
}

local plugins_disabled = {
	"echasnovski/mini.bufremove",
	"echasnovski/mini.indentscope",
}

local plugins = {}

for _, plugin_name in ipairs(plugins_enabled) do
	table.insert(plugins, { plugin_name, enabled = true })
end

for _, plugin_name in ipairs(plugins_disabled) do
	table.insert(plugins, { plugin_name, enabled = false })
end

return plugins

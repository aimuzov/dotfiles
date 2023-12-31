return {
	{
		"mg979/vim-visual-multi",
		optional = true,
	},

	{
		"folke/flash.nvim",
		optional = true,
		opts = { modes = { search = { enabled = false } } },
	},

	{
		"Wansmer/sibling-swap.nvim",
		optional = true,
		dependencies = { "nvim-treesitter" },
		opts = {
			highlight_node_at_cursor = { ms = 250 },
			use_default_keymaps = true,
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		optional = true,
		keys = { { "[x", [[<cmd>lua require("treesitter-context").go_to_context()<cr>]] } },
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_, opts)
			local harpoon = require("harpoon")

			harpoon:setup(opts)

			vim.keymap.set("n", "<c-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<leader>fa", function()
				harpoon:list():append()
			end, { desc = "Append file to harpoon list" })

			for i = 1, 5, 1 do
				vim.keymap.set("n", "<c-" .. i .. ">", function()
					harpoon:list():select(i)
				end)
			end
		end,
	},
}

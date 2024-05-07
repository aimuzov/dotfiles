vim.keymap.set({ "n", "v" }, "d", [["_d]])

vim.keymap.set({ "i" }, "<c-s-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set({ "n" }, "<c-s-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set({ "v" }, "<c-s-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })

vim.keymap.set({ "i" }, "<c-s-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set({ "n" }, "<c-s-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set({ "v" }, "<c-s-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

vim.keymap.set({ "v" }, "<c-i>", "<cmd>'<,'>sort i<cr>", { desc = "Sort lines" })
vim.keymap.set({ "n" }, "<c-/>", "<cmd>lua LazyVim.terminal()<cr>", { desc = "Terminal (cwd)" })

vim.keymap.set({ "n" }, "<leader>\\", "<C-W>v", { desc = "Split window right" })
vim.keymap.set({ "n" }, "<leader>w\\", "<C-W>v", { desc = "Split window right" })

vim.keymap.set({ "n" }, "<leader>uR", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

vim.keymap.set({ "n" }, "<c-s-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set({ "n" }, "<c-s-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set({ "i" }, "<c-s-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set({ "i" }, "<c-s-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set({ "v" }, "<c-s-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
vim.keymap.set({ "v" }, "<c-s-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })

vim.keymap.set({ "n" }, "<c-u>", "<c-u>zz")
vim.keymap.set({ "n" }, "<c-d>", "<c-d>zz")
vim.keymap.set({ "n" }, "<c-b>", "<c-b>zz")
vim.keymap.set({ "n" }, "<c-f>", "<c-f>zz")

vim.keymap.set({ "n", "v" }, "y", [["+y]])
vim.keymap.set({ "n", "v" }, "p", [["+p]])
vim.keymap.set({ "v" }, "p", [["_dp]])
vim.keymap.set({ "n", "v" }, "c", [["+c]])
vim.keymap.set({ "n", "v" }, "x", [["+x]])
vim.keymap.set({ "n", "v" }, "d", [["_d]])
vim.keymap.set({ "n", "v" }, "D", [["_D]])

vim.keymap.set("n", "<leader>w\\", "<C-W>v", { desc = "Split window right" })
vim.keymap.set("n", "<leader>\\", "<C-W>v", { desc = "Split window right" })

vim.keymap.set("n", "<leader>uR", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

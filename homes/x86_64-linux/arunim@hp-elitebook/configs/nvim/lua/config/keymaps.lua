vim.keymap.set("v", "<C-S-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selected line down" })
vim.keymap.set("v", "<C-S-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selected line up" })
vim.keymap.set("n", "<C-S-Up>", ":m .-2<CR>==", { desc = "Move current line up" })
vim.keymap.set("n", "<C-S-Down>", ":m .+1<CR>==", { desc = "Move current line down" })

vim.keymap.set("v", "<Tab>", ">gv", { desc = "indent by 1" })
vim.keymap.set("n", "<Tab>", "v><C-\\><C-N>", { desc = "indent by 1" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "indent by -1" })
vim.keymap.set("n", "<S-Tab>", "v<<C-\\><C-N>", { desc = "indent by -1" })

vim.keymap.set("n", "<C-Bs>", "db", { desc = "Delete previous word", noremap = true, silent = true })
vim.keymap.set("n", "<C-Delete>", "dw", { desc = "Delete next word", noremap = true, silent = true })
vim.keymap.set("n", "<C-A>", "ggVG", { desc = "Select all", noremap = true, silent = true })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without losing buffer" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy to system clipboard" })

vim.keymap.set(
  "n",
  "<leader>rw",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace current word with regex" }
)

local keymap = vim.keymap

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>w", "<cmd>w!<CR>")

keymap.set("n", "<leader>q", "<cmd>q!<CR>")

keymap.set("n", "j", [[v:count?'j':'gj']], { noremap = true, expr = true })

keymap.set("n", "k", [[v:count?'k':'gk']], { noremap = true, expr = true })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

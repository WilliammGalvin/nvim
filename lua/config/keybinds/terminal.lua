local map = vim.keymap.set
local terminal = require("config.actions.terminal")

map({ "n", "t" }, "<leader>ft", terminal.toggle, { desc = "Toggle terminal" })
map("t", "<Esc><Esc>", "<C-\\><C-n><cmd>bdelete!<CR>", { desc = "Close terminal" })

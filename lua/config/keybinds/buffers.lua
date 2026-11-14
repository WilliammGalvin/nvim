local map = vim.keymap.set
local buffers = require("config.actions.buffers")

-- navigation
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- closing
map("n", "<leader>bd", buffers.delete, { desc = "Delete buffer" })
map("n", "<leader>bo", buffers.delete_others, { desc = "Delete other buffers" })
map("n", "<leader>bb", buffers.delete_all, { desc = "Delete all buffers" })

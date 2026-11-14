local map = vim.keymap.set
local themes = require("config.actions.themes")

map("n", "<leader>uc", themes.pick, { desc = "Pick colorscheme" })
map("n", "<leader>un", themes.next, { desc = "Next colorscheme" })
map("n", "<leader>up", themes.prev, { desc = "Previous colorscheme" })

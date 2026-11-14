local map = vim.keymap.set

-- general
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- window navigation and splits
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Split window horizontally" })

-- scrolling and searching
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down, keep cursor centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up, keep cursor centered" })
map("n", "n", "nzzzv", { desc = "Next search match, centered" })
map("n", "N", "Nzzzv", { desc = "Previous search match, centered" })

-- editing
map("n", "J", "mzJ`z", { desc = "Join lines, keep cursor position" })
map("n", "x", '"_x', { desc = "Delete character without yanking" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
map("x", "<leader>p", '"_dP', { desc = "Paste over selection, keep register" })
map(
	"n",
	"<leader>sr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor in file" }
)

-- indenting
map("v", "<", "<gv", { desc = "Indent left, keep selection" })
map("v", ">", ">gv", { desc = "Indent right, keep selection" })

-- moving lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

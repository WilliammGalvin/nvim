return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
		{ "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Grep word under cursor" },
		{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
		{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help pages" },
		{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Search keymaps" },
		{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search in current file" },
	},
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<Esc>"] = actions.close,
					},
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
	end,
}

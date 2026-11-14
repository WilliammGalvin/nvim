return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
	},
	opts = {
		close_if_last_window = true,
		window = {
			position = "left",
			width = 30,
		},
		filesystem = {
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = {
				hide_dotfiles = true,
				never_show = { ".DS_Store" },
				show_hidden_count = false,
			},
			window = {
				fuzzy_finder_mappings = {
					["<C-j>"] = "move_cursor_down",
					["<C-k>"] = "move_cursor_up",
				},
			},
		},
	},
}

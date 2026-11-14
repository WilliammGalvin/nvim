return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 300,
		spec = {
			{ "<leader>b", group = "buffer" },
			{ "<leader>c", group = "code" },
			{ "<leader>f", group = "find / terminal" },
			{ "<leader>s", group = "search / replace" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer-local keymaps (which-key)",
		},
	},
}

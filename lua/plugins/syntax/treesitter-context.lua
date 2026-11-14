return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	opts = { max_lines = 3 },
	keys = {
		{
			"<leader>cx",
			function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end,
			desc = "Jump to context (function header)",
		},
	},
}

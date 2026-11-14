return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		delay = 200,
		large_file_cutoff = 2000,
		providers = { "lsp", "treesitter", "regex" },
		filetypes_denylist = { "neo-tree", "TelescopePrompt" },
	},
	config = function(_, opts)
		require("illuminate").configure(opts)
	end,
}

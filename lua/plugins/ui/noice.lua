return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
		notify = { enabled = true, view = "mini" },
		routes = {
			{ filter = { event = "notify", kind = "info" }, opts = { skip = true } },
			{ filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
		},
	},
	keys = {
		{ "<leader>nh", "<cmd>Noice history<CR>", desc = "Message history" },
	},
}

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "Format buffer/selection",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			ocaml = { "ocamlformat" },
			json = { "prettier" },
			markdown = { "prettier" },
			sh = { "shfmt" },
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 1000, lsp_format = "fallback" }
		end,
	},
	init = function()
		vim.api.nvim_create_user_command("FormatToggle", function(opts)
			if opts.bang then
				vim.b.disable_autoformat = not vim.b.disable_autoformat
			else
				vim.g.disable_autoformat = not vim.g.disable_autoformat
			end
		end, { bang = true, desc = "Toggle format-on-save (! = this buffer only)" })
	end,
}

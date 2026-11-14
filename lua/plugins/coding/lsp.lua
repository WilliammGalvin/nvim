return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				ensure_installed = { "clangd", "lua_ls" },
				automatic_enable = false,
			},
		},
	},
	config = function()
		vim.diagnostic.config({
			virtual_text = true,
			severity_sort = true,
			float = { border = "rounded" },
		})

		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=never",
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
				},
			},
		})

		local servers = { "clangd", "lua_ls" }
		if vim.fn.executable("ocamllsp") == 1 then
			table.insert(servers, "ocamllsp")
		end
		vim.lsp.enable(servers)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(args)
				local function lmap(keys, fn, desc)
					vim.keymap.set("n", keys, fn, { buffer = args.buf, desc = "LSP: " .. desc })
				end

				lmap("gd", vim.lsp.buf.definition, "Go to definition")
				lmap("gD", vim.lsp.buf.declaration, "Go to declaration")
				lmap("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				lmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
				lmap("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
			end,
		})
	end,
}

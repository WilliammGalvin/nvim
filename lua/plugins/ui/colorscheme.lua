local themes = require("config.themes")

return {
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.background = "dark"
			vim.cmd.colorscheme(themes.default)
		end,
	},
	{ "folke/tokyonight.nvim", lazy = true },
}

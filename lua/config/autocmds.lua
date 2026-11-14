local augroup = vim.api.nvim_create_augroup("config", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function(args)
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.bo[args.buf].buflisted = false
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	callback = function()
		if vim.api.nvim_buf_get_name(0) == "" then
			return
		end

		vim.schedule(function()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if
					vim.api.nvim_buf_is_valid(buf)
					and vim.bo[buf].buflisted
					and vim.bo[buf].buftype == ""
					and vim.api.nvim_buf_get_name(buf) == ""
					and not vim.bo[buf].modified
					and vim.fn.bufwinid(buf) == -1
					and vim.api.nvim_buf_line_count(buf) == 1
					and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
				then
					pcall(vim.api.nvim_buf_delete, buf, {})
				end
			end
		end)
	end,
})

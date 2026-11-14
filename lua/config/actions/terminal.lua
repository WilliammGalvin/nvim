local M = {}

local height = 15

function M.toggle()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_buf_delete(buf, { force = true })
			return
		end
	end

	vim.cmd(("botright %dsplit | terminal"):format(height))
	vim.cmd("startinsert")
end

return M

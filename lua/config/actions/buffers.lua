local M = {}

local function delete(buf)
	if vim.bo[buf].modified then
		return false
	end

	local replacement
	local alt = vim.fn.bufnr("#")
	if alt > 0 and alt ~= buf and vim.api.nvim_buf_is_valid(alt) and vim.bo[alt].buflisted then
		replacement = alt
	else
		for _, b in ipairs(vim.api.nvim_list_bufs()) do
			if b ~= buf and vim.bo[b].buflisted then
				replacement = b
				break
			end
		end
	end
	replacement = replacement or vim.api.nvim_create_buf(true, false) -- empty buffer

	for _, win in ipairs(vim.fn.win_findbuf(buf)) do
		vim.api.nvim_win_set_buf(win, replacement)
	end

	return pcall(vim.api.nvim_buf_delete, buf, {})
end

local function delete_buffers(keep_current)
	local current = vim.api.nvim_get_current_buf()
	local skipped = 0

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and not (keep_current and buf == current) then
			if not delete(buf) then
				skipped = skipped + 1
			end
		end
	end

	if skipped > 0 then
		vim.notify(skipped .. " buffer(s) kept (unsaved changes)", vim.log.levels.WARN)
	end
end

function M.delete()
	local buf = vim.api.nvim_get_current_buf()

	if vim.bo[buf].buftype ~= "" then
		vim.cmd("bdelete!")
		return
	end

	if not delete(buf) then
		vim.notify("Buffer has unsaved changes", vim.log.levels.WARN)
	end
end

function M.delete_others()
	delete_buffers(true)
end
function M.delete_all()
	delete_buffers(false)
end

return M

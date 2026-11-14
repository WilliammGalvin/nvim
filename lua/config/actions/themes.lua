local themes = require("config.themes")

local M = {}

local state_file = vim.fn.stdpath("data") .. "/colorscheme.txt"

local function all_themes()
	local seen, all = {}, {}
	local candidates = vim.list_extend(vim.deepcopy(themes.list), vim.fn.getcompletion("", "color"))
	for _, name in ipairs(candidates) do
		if not seen[name] then
			seen[name] = true
			all[#all + 1] = name
		end
	end
	return all
end

local function load_saved()
	local f = io.open(state_file, "r")
	if not f then
		return nil
	end
	local name = f:read("*l")
	f:close()
	if name and name ~= "" and vim.tbl_contains(all_themes(), name) then
		return name
	end
end

local function save(name)
	local f = io.open(state_file, "w")
	if not f then
		return
	end
	f:write(name)
	f:close()
end

local initial = load_saved() or themes.default

local current = 1
for i, name in ipairs(themes.list) do
	if name == initial then
		current = i
		break
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		for i, name in ipairs(themes.list) do
			if name == vim.g.colors_name then
				current = i
				return
			end
		end
	end,
})

local function load(name)
	local ok, err = pcall(vim.cmd.colorscheme, name)
	if not ok then
		vim.notify(("Couldn't load %s: %s"):format(name, err), vim.log.levels.WARN)
		return false
	end
	vim.api.nvim_echo({ { name, "Title" } }, false, {})
	save(name)
	return true
end

local function apply(index)
	current = index
	load(themes.list[index])
end

local function step(direction)
	apply((current - 1 + direction) % #themes.list + 1)
end

function M.initial()
	return initial
end

function M.restore()
	local ok, err = pcall(vim.cmd.colorscheme, initial)
	if not ok then
		vim.notify(("Couldn't load %s: %s"):format(initial, err), vim.log.levels.WARN)
	end
end

function M.set(name)
	if not vim.tbl_contains(all_themes(), name) then
		vim.notify(("Unknown colorscheme: %s"):format(name), vim.log.levels.ERROR)
		return
	end
	load(name)
end

function M.next()
	step(1)
end
function M.prev()
	step(-1)
end

function M.pick(show_all)
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local original = vim.g.colors_name
	local confirmed = false

	local function preview()
		local entry = action_state.get_selected_entry()
		if entry then
			pcall(vim.cmd.colorscheme, entry.value)
		end
	end

	pickers
		.new({}, {
			prompt_title = show_all and "Colorscheme: all (H for chosen)" or "Colorscheme: chosen (H for all)",
			finder = finders.new_table({ results = show_all and all_themes() or themes.list }),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				local function move(fn)
					return function()
						fn(prompt_bufnr)
						preview()
					end
				end
				for _, mode in ipairs({ "i", "n" }) do
					map(mode, "<C-n>", move(actions.move_selection_next))
					map(mode, "<C-p>", move(actions.move_selection_previous))
					map(mode, "<Down>", move(actions.move_selection_next))
					map(mode, "<Up>", move(actions.move_selection_previous))
				end
				map("n", "j", move(actions.move_selection_next))
				map("n", "k", move(actions.move_selection_previous))

				vim.api.nvim_create_autocmd("BufWipeout", {
					buffer = prompt_bufnr,
					once = true,
					callback = function()
						if not confirmed and original then
							vim.schedule(function()
								pcall(vim.cmd.colorscheme, original)
							end)
						end
					end,
				})

				actions.select_default:replace(function()
					local entry = action_state.get_selected_entry()
					confirmed = true
					actions.close(prompt_bufnr)
					if entry then
						vim.schedule(function()
							load(entry.value)
						end)
					end
				end)

				local function toggle()
					actions.close(prompt_bufnr)
					vim.schedule(function()
						M.pick(not show_all)
					end)
				end
				map("i", "H", toggle)
				map("n", "H", toggle)
				return true
			end,
		})
		:find()
end

vim.api.nvim_create_user_command("Theme", function(opts)
	if opts.args == "" then
		M.pick(opts.bang)
	else
		M.set(opts.args)
	end
end, {
	nargs = "?",
	bang = true,
	complete = function(arglead)
		return vim.tbl_filter(function(name)
			return name:find(arglead, 1, true) == 1
		end, all_themes())
	end,
	desc = "Set colorscheme (no arg opens picker, ! shows all)",
})

if vim.v.vim_did_enter == 1 then
	M.restore()
else
	vim.api.nvim_create_autocmd("VimEnter", {
		once = true,
		callback = function()
			vim.schedule(M.restore)
		end,
	})
end

return M

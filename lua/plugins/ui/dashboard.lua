local art = "coffee"
local name = "William"
local section_gap = 2

local projects = {
	{
		category = "personal",
		items = {
			{ name = "cherry", path = "~/projects/compilers/Cherry" },
			{ name = "petal", path = "~/projects/compilers/dependencies/petal" },
			{ name = "dotorchard", path = "~/projects/compilers/dependencies/dotorchard" },
		},
	},
	{
		category = "school",
		items = {
			{ name = "factory_core", path = "~/projects/school/factory_core" },
			{ name = "orbit", path = "~/projects/school/orbit" },
		},
	},
	{
		category = "nvim",
		items = {
			{ name = "config", path = "~/.config/nvim/" },
		},
	},
}

local greetings = {
	{ from = 0, text = "Late night coding, %s?" },
	{ from = 4, text = "Up before the sun, %s?" },
	{ from = 6, text = "Good morning, %s" },
	{ from = 12, text = "Good afternoon, %s" },
	{ from = 15, text = "Afternoon grind, %s" },
	{ from = 17, text = "Good evening, %s" },
	{ from = 21, text = "Night owl mode, %s" },
}

local function load_art(art_name)
	local path = ("%s/resources/ascii/%s.txt"):format(vim.fn.stdpath("config"), art_name)
	if vim.fn.filereadable(path) == 1 then
		return table.concat(vim.fn.readfile(path), "\n")
	end
	return "NVIM"
end

local function greeting()
	local hour = tonumber(os.date("%H"))
	local text = greetings[1].text
	for _, g in ipairs(greetings) do
		if hour >= g.from then
			text = g.text
		end
	end
	return text:format(name)
end

local function open_project(path)
	vim.cmd.cd(path)
	vim.cmd("Neotree focus")
end

local function muted(text, indent, padding)
	return {
		text = { { text, hl = "Comment" } },
		indent = indent,
		padding = padding or 0,
	}
end

local function project_items()
	local items = {}
	local count = 0

	for _, group in ipairs(projects) do
		local group_items = {}

		for _, p in ipairs(group.items) do
			local path = vim.fn.expand(p.path)
			if count < 9 and vim.fn.isdirectory(path) == 1 then
				count = count + 1
				group_items[#group_items + 1] = {
					key = tostring(count),
					desc = p.name,
					indent = 4,
					action = function()
						open_project(path)
					end,
				}
			end
		end

		if #group_items > 0 then
			group_items[#group_items].padding = 1
			items[#items + 1] = muted(group.category, 2)
			vim.list_extend(items, group_items)
		end
	end

	if #items > 0 then
		items[#items].padding = section_gap
		table.insert(items, 1, { title = "Pinned Projects", padding = 1 })
	end
	return items
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dashboard = {
			enabled = true,
			width = 40,
			preset = {
				header = load_art(art),
			},
			sections = {
				{ section = "header" },
				function()
					return {
						{ text = { { greeting(), hl = "Comment" } }, align = "center", padding = section_gap },
					}
				end,
				project_items,
				{ section = "startup" },
			},
		},
	},
}

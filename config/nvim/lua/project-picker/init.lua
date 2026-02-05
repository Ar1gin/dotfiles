local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")

local project_file_path = vim.fn.stdpath("data") .. "/project_picker/projects"

-- Project entry structure:
-- [1] Path
-- [2] Display name

local M = {}

local load_file = function()
	local file = io.open(project_file_path, "r")
	if file == nil then
		M.projects = nil
	end

	local projects = {}
	local current = {}
	for str in file:lines() do
		table.insert(current, str)
		if #current == 2 then
			table.insert(projects, current)
			current = {}
		end
	end
	if #current ~= 0 then
		file:close()
		return {}
	end

	M.loaded = true
	M.projects = projects
	file:close()
end

local load_projects = function()
	if M.loaded then
		return
	end
	load_file()

	if M.loaded then
		return
	end
	vim.ui.select({ "Create", "Do not create" }, {
		prompt = "Could not open project list file, create one?",
	}, function(input)
		if input == "Create" then
			M.projects = {}
			M.modified = true
			M.loaded = true
			M.save_projects()
		end
	end)
end

-- M.add_project = function(name, path)
-- 	vim.ui.input(
-- 		{
-- 			prompt = "Project name (" .. path .. ")",
-- 			default = string.gsub(path, ".*/", ""),
-- 		},
-- 		function(input)
-- 			if input == "" then
-- 				return
-- 			end
--
-- 			if M.projects == nil then
-- 				return
-- 			end
-- 			M.modified = true
-- 			table.insert(M.projects, { path, input })
-- 		end
-- 	)
-- end
--
-- M.rename_project = function(entry)
-- 	vim.ui.input(
-- 		{
-- 			prompt = "New project name (" .. entry[1] .. ")",
-- 			default = entry[2],
-- 		},
-- 		function(input)
-- 			if input == "" then
-- 				return
-- 			end
--
-- 			M.modified = true
-- 			entry[2] = input
-- 		end
-- 	)
-- end
--
-- M.remove_project = function(index)
-- 	if M.projects == nil then
-- 		return
-- 	end
--
-- 	M.modified = true
-- 	table.remove(index)
-- end

M.save_projects = function()
	if not M.loaded then
		load_projects()
	end

	if M.projects == nil then
		return
	end
	if not M.modified then
		return
	end

	local file = io.open(project_file_path, "w+")

	local projects = M.projects or {}
	for _, value in ipairs(projects) do
		file:write(value[1], "\n")
		file:write(value[2], "\n")
	end

	file:close()
end

M.pick = function(opts)
	opts = opts or {}

	load_projects()
	local projects = M.projects

	if projects == nil then
		vim.print("Project file could not be loaded")
		return
	end

	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 32 },
			{ remaining = true },
		},
	})
	local make_display = function(entry)
		return displayer({
			{ entry.value[2], "TelescopeResultsNormal" },
			{ entry.value[1], "TelescopeResultsComment" },
		})
	end

	pickers.new(opts, {
		prompt_title = "Projects",
		finder = finders.new_table({
			results = projects,
			entry_maker = function(entry)
				return {
					value = entry,
					display = make_display,
					ordinal = entry[2]..entry[1],
				}
			end,
		}),
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				vim.api.nvim_set_current_dir(selection.value[1])
			end)
			actions.close:enhance({
				post = function()
					M.save_projects()
				end,
			})
			return true
		end,
	}):find()
end

M.edit = function ()
	vim.cmd("edit " .. project_file_path)
end

return M

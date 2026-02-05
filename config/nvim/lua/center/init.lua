local M = {
	skip_filetypes = {},
	enabled = false,
}

M.setup = function(ctx)
	ctx = ctx or {}

	M.skip_filetypes = ctx.skip_filetypes or {}
	if type(ctx.enabled) == "boolean" and ctx.enabled then
		M.enable()
	else
		M.enabled = false
	end
end

local function must_skip_file(skip_filetypes, current_type)
	if skip_filetypes == nil then
		return false
	end

	for _, value in ipairs(skip_filetypes) do
		if value == current_type then
			return true
		end
	end

	return false
end

local function stay_centered()
	if must_skip_file(M.skip_filetypes, vim.bo.filetype) then
		return
	end

	local line = vim.api.nvim_win_get_cursor(0)[1]
	if line ~= vim.b.last_line then
		vim.cmd("norm! zz")
		-- vim.b.last_line = line
		-- if ctx.mode == "insert" then
		-- 	local column = vim.fn.getcurpos()[5]
		-- 	vim.fn.cursor({ line, column })
		-- end
	end
end


M.enable = function()
	if M.enabled then
		return
	end

	M.enabled = true
	M.group = vim.api.nvim_create_augroup("StayCentered", { clear = true })

	local add_command = vim.api.nvim_create_autocmd
	add_command("CursorMovedI", {
		group = M.group,
		callback = function()
			stay_centered({ mode = "insert" })
		end,
	})
	add_command("CursorMoved", {
		group = M.group,
		callback = function()
			stay_centered({ mode = "other" })
		end,
	})
	add_command("BufEnter", {
		group = M.group,
		callback = function()
			stay_centered({ mode = "other" })
		end,
	})
	stay_centered({ mode = "other" })
end

M.disable = function()
	if not M.enabled then
		return
	end

	M.enabled = false
	vim.api.nvim_del_augroup_by_id(M.group)
end

M.toggle = function()
	if M.enabled then
		M.disable()
	else
		M.enable()
	end
end

return M

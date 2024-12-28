local M = {}

M.cfg = {
	skip_filetypes = {},
	enabled = true,
}

M.setup = function(ctx)
	if ctx == nil then
		return
	end

	M.cfg.skip_filetypes = ctx.skip_filetypes or {}
	if type(ctx.enabled) == "boolean" then
		M.cfg.enabled = ctx.enabled
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

local function stay_centered(ctx)
	if not ctx.cfg.enabled then
		return
	end
	if must_skip_file(ctx.cfg.skip_filetypes, vim.bo.filetype) then
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

local add_group = vim.api.nvim_create_augroup
local group = add_group("StayCentered", { clear = true })

local add_command = vim.api.nvim_create_autocmd
add_command("CursorMovedI", {
	group = group,
	callback = function()
		stay_centered({ mode = "insert", cfg = M.cfg })
	end,
})
add_command("CursorMoved", {
	group = group,
	callback = function()
		stay_centered({ mode = "other", cfg = M.cfg })
	end,
})
add_command("BufEnter", {
	group = group,
	callback = function()
		stay_centered({ mode = "other", cfg = M.cfg })
	end,
})

M.enable = function()
	M.cfg.enabled = true
	stay_centered({ mode = "other", cfg = M.cfg })
end

M.disable = function()
	M.cfg.enabled = false
end

M.toggle = function()
	if M.cfg.enabled then
		M.disable()
	else
		M.enable()
	end
end

return M

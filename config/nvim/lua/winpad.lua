local M = {}

M.setup = function(opts)
	M.enabled = false
	M.pad_target = opts.pad_target or 35
	M.pad_min_width = opts.pad_min_width or 120
	if opts.enabled then
		M.enable_pad()
	end
end

M.toggle = function()
	if M.enabled then
		M.disable_pad()
	else
		M.enable_pad()
	end
end

M.disable_pad = function()
	if not M.enabled then
		return
	end
	vim.api.nvim_del_augroup_by_id(M.group)
	M.enabled = false
	M.pad_all_windows()
end

M.enable_pad = function()
	if M.enabled then
		return
	end
	local group = vim.api.nvim_create_augroup("PadGroup", {})
	M.group = group
	vim.api.nvim_create_autocmd({ "WinResized", "WinNew", "VimEnter" }, {
		group = group,
		callback = function(ev)
			if ev.event == "WinResized" then
				for _, window in ipairs(vim.v.event.windows) do
					M.pad_window(window)
				end
			else
				M.pad_all_windows()
			end
		end
	})
	M.enabled = true
	M.pad_all_windows()
end

M.update_pad_size = function(win)
	local position = vim.api.nvim_win_get_position(win)
	local target_pad = math.max(0, M.pad_target - position[2])
	local width = vim.api.nvim_win_get_width(win)
	local ui_width = vim.api.nvim_list_uis()[1].width
	local min_left = math.max(math.floor(ui_width / 2), M.pad_min_width)
	local max_pad = math.max(0, width - min_left)
	local total_pad = math.min(max_pad, target_pad)
	M.set_pad_size(win, total_pad)
	return total_pad
end

M.set_pad_size = function(win, pad)
	vim.api.nvim_win_set_var(win, "pad_size", pad)
end
M.get_pad_size = function(win)
	return vim.api.nvim_win_get_var(win, "pad_size") or 0
end

M.pad_window = function(win)
	if (not M.enabled) or (#vim.api.nvim_win_get_config(win).relative > 0) then
		M.set_pad_size(win, 0)
		vim.api.nvim_set_option_value("statuscolumn", "", { win = win })
	else
		local total_pad = M.update_pad_size(win)
		vim.api.nvim_set_option_value("statuscolumn",
			"%#Normal#%{\"" ..
			-- Sometimes I feel like I shouldn't be allowed to touch computers...
			string.rep("⠀", total_pad) .. "\"}%#LineNr# %2.2s%4.4l%#LinePad#%{v:virtnum<=0?\"┃\":\"⠀⠀⠀⠀┃\"}",
			{ win = win })
	end
end

M.pad_all_windows = function()
	for _, window in ipairs(vim.api.nvim_list_wins()) do
		M.pad_window(window)
	end
end

return M

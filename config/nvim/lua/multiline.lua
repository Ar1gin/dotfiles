local M = {}

M.setup = function(opts)
	M.max_new_lines = opts.max_new_lines or 1000
	M.keep_existing = opts.keep_existing or true
	M.void_bounds = opts.void_bounds or true
end

M.nlines = function(count)
	-- Please, tell me there is a better way
	local output = {}
	for _ = 1, count do
		table.insert(output, "")
	end
	return output
end

M.remove_surround = function()
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)

	local count = math.max(1, vim.v.count)

	-- Bottom pad
	local delete_bottom = 0
	for _ = 1, count do
		local delete_line = line + delete_bottom
		if delete_line == lines then
			break
		end
		local next_line = vim.api.nvim_buf_get_lines(0, delete_line, delete_line + 1, false)[1]
		if vim.trim(next_line) ~= "" then
			break
		end
		delete_bottom = delete_bottom + 1
	end
	vim.api.nvim_buf_set_lines(0, line, line + delete_bottom, false, {})

	-- Top pad
	local delete_top = 0
	for _ = 1, count do
		local delete_line = line - delete_top
		if delete_line == 1 then
			break
		end
		local prev_line = vim.api.nvim_buf_get_lines(0, delete_line - 2, delete_line - 1, false)[1]
		if vim.trim(prev_line) ~= "" then
			break
		end
		delete_top = delete_top + 1
	end
	vim.api.nvim_buf_set_lines(0, line - delete_top - 1, line - 1, false, {})
end

M.remove_all_surround = function()
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)

	-- Bottom pad
	local delete_bottom = 0
	while true do
		local delete_line = line + delete_bottom
		if delete_line == lines then
			break
		end
		local next_line = vim.api.nvim_buf_get_lines(0, delete_line, delete_line + 1, false)[1]
		if vim.trim(next_line) ~= "" then
			break
		end
		delete_bottom = delete_bottom + 1
	end
	vim.api.nvim_buf_set_lines(0, line, line + delete_bottom, false, {})

	-- Top pad
	local delete_top = 0
	while true do
		local delete_line = line - delete_top
		if delete_line == 1 then
			break
		end
		local prev_line = vim.api.nvim_buf_get_lines(0, delete_line - 2, delete_line - 1, false)[1]
		if vim.trim(prev_line) ~= "" then
			break
		end
		delete_top = delete_top + 1
	end
	vim.api.nvim_buf_set_lines(0, line - delete_top - 1, line - 1, false, {})
end

M.surround_newlines = function(input)
	return function()
		local line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)

		local count = math.min(math.max(1, vim.v.count), M.max_new_lines)

		-- Bottom pad
		local add_bottom = count
		if M.keep_existing then
			for i = 1, count do
				if line + i - 1 == lines then
					if M.void_bounds then
						add_bottom = 0
					end
					break
				end
				local next_line = vim.api.nvim_buf_get_lines(0, line + i - 1, line + i, false)[1]
				if vim.trim(next_line) == "" then
					add_bottom = add_bottom - 1
				else
					break
				end
			end
		end
		vim.api.nvim_buf_set_lines(0, line, line, false, M.nlines(add_bottom))

		-- Top pad
		local add_top = count
		if M.keep_existing then
			for i = 1, count do
				if line - i + 1 == 1 then
					if M.void_bounds then
						add_top = 0
					end
					break
				end
				local prev_line = vim.api.nvim_buf_get_lines(0, line - i - 1, line - i, false)[1]
				if vim.trim(prev_line) == "" then
					add_top = add_top - 1
				else
					break
				end
			end
		end
		vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, M.nlines(add_top))

		if input ~= "" then
			vim.api.nvim_input(input)
		end
	end
end

M.next_surround = function(input)
	return function()
		local line = vim.api.nvim_win_get_cursor(0)[1]
		local count = math.min(math.max(1, vim.v.count), M.max_new_lines)
		vim.api.nvim_buf_set_lines(0, line, line, false, M.nlines(count))
		vim.api.nvim_win_set_cursor(0, { line + count, 0 })
		if input ~= "" then
			vim.api.nvim_input(input)
		end
	end
end

M.prev_surround = function(input)
	return function()
		local line = vim.api.nvim_win_get_cursor(0)[1]
		local count = math.min(math.max(1, vim.v.count), M.max_new_lines)
		vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, M.nlines(count))
		vim.api.nvim_win_set_cursor(0, { line, 0 })
		if input ~= "" then
			vim.api.nvim_input(input)
		end
	end
end

M.set_surround = function()
	M.remove_all_surround()
	M.surround_newlines("")()
end

-- Breaking lines with whitespace is a bit wonky but I don't care
M.break_into_lines = function()
	local v_start = vim.fn.getpos("v")
	local v_end = vim.fn.getpos(".")
	if (v_end[2] < v_start[2]) or (v_end[2] == v_start[2] and v_end[3] < v_start[3]) then
		v_start, v_end = v_end, v_start
	end

	-- End split
	local end_line = vim.api.nvim_buf_get_lines(0, v_end[2] - 1, v_end[2], false)[1]
	if v_end[3] < #end_line then
		local line_start = end_line:sub(1, v_end[3]):gsub("%s+$", "")
		local line_end = end_line:sub(v_end[3] + 1):gsub("^%s+", "")
		local pad = line_start:match("^%s+") or ""
		vim.api.nvim_buf_set_lines(0, v_end[2] - 1, v_end[2], false, {
			line_start,
			pad .. line_end
		})
	end

	-- Start split
	local start_line = vim.api.nvim_buf_get_lines(0, v_start[2] - 1, v_start[2], false)[1]
	if v_start[3] > 1 then
		local line_start = start_line:sub(1, v_start[3] - 1):gsub("%s+$", "")
		local line_end = start_line:sub(v_start[3]):gsub("^%s+", "")
		local pad = line_start:match("^%s+") or ""
		vim.api.nvim_buf_set_lines(0, v_end[2] - 1, v_end[2], false, {
			line_start,
			pad .. line_end
		})
		vim.api.nvim_win_set_cursor(0, { v_start[2] + 1, vim.v.maxcol })
	else
		vim.api.nvim_win_set_cursor(0, { v_start[2], vim.v.maxcol })
	end

	vim.api.nvim_input("<Esc>>>")
end

return M

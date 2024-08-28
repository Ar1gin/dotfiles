local M = {}

local set_opfunc = vim.fn[vim.api.nvim_exec2([[
	func s:set_opfunc(val)
		let &opfunc = a:val
	endfunc
	echon get(function("s:set_opfunc"), "name")
]], { output = true })["output"]]

M.cases = {
	pascal = function(words)
		local output = ""
		for _, word in ipairs(words) do
			output = output .. string.upper(string.sub(word, 1, 1)) .. string.lower(string.sub(word, 2))
		end
		return output
	end,
	snake  = function(words)
		local output = ""
		for i, word in ipairs(words) do
			output = output .. (i == 1 and "" or "_") .. string.lower(word)
		end
		return output
	end,
	kebab  = function(words)
		local output = ""
		for i, word in ipairs(words) do
			output = output .. (i == 1 and "" or "-") .. string.lower(word)
		end
		return output
	end,
	camel  = function(words)
		local output
		for i, word in ipairs(words) do
			if i == 1 then
				output = string.lower(word)
			else
				output = output .. string.upper(string.sub(word, 1, 1)) .. string.lower(string.sub(word, 2))
			end
		end
		return output
	end,
	upper  = function(words)
		local output = ""
		for i, word in ipairs(words) do
			output = output .. (i == 1 and "" or "_") .. string.upper(word)
		end
		return output
	end,
}

M.set_word_case = function(line, case)
	local split_by_pattern = function(words, pattern, offset, remove)
		local output = {}
		for _, word in ipairs(words) do
			while true do
				local match_start, match_end = string.find(word, pattern)
				if match_start then
					table.insert(output, string.sub(word, 1, match_start - 1 + offset))
					local next_word
					if remove then
						next_word = match_end + 1
					else
						next_word = match_start + offset
					end
					word = string.sub(word, next_word)
				else
					if #word > 0 then
						table.insert(output, word)
					end
					break
				end
			end
		end
		return output
	end
	local words = { line }
	local patterns = {
		{ "%l%u",  1, false },
		{ "[_-]+", 0, true },
	}
	for _, pattern in ipairs(patterns) do
		words = split_by_pattern(words, pattern[1], pattern[2], pattern[3])
	end
	for _, word in ipairs(words) do
		print(word)
	end
	return M.cases[case](words)
end

M.set_case = function(to_change, case)
	local changed = ""
	while true do
		local match_start, match_end = string.find(to_change, "%a[%a_-]*")
		if match_start then
			changed = changed ..
				string.sub(to_change, 1, match_start - 1) ..
				M.set_word_case(string.sub(to_change, match_start, match_end), case)
			to_change = string.sub(to_change, match_end + 1)
		else
			return changed .. to_change
		end
	end
end

M.convert_case = function(case)
	return function()
		set_opfunc(function(motion)
			local sel_start = vim.fn.getpos("'[")
			local sel_end = vim.fn.getpos("']")
			local lines = vim.api.nvim_buf_get_lines(0, sel_start[2] - 1, sel_end[2], false)
			if motion == "line" then
				for i, line in ipairs(lines) do
					lines[i] = M.set_case(line, case)
				end
			end
			if motion == "block" then
				local col_start = sel_start[3]
				local col_end = sel_end[3] + sel_end[4]
				for i, line in ipairs(lines) do
					lines[i] = string.sub(line, 1, col_start - 1) ..
						M.set_case(string.sub(line, col_start, col_end), case) ..
						string.sub(line, col_end + 1)
				end
			end
			if motion == "char" then
				if sel_start[2] == sel_end[2] then
					lines[1] = string.sub(lines[1], 1, sel_start[3] - 1) ..
						M.set_case(string.sub(lines[1], sel_start[3], sel_end[3]), case) ..
						string.sub(lines[1], sel_end[3] + 1)
				else
					local last = sel_end[2] - sel_start[2] + 1
					lines[1] = string.sub(lines[1], 1, sel_start[3] - 1) ..
						M.set_case(string.sub(lines[1], sel_start[3]), case)
					lines[last] = M.set_case(string.sub(lines[last], 1, sel_end[3]), case) ..
						string.sub(lines[last], sel_end[3] + 1)
					for i, line in ipairs(lines) do
						if i ~= 1 and i ~= last then
							lines[i] = M.set_case(line, case)
						end
					end
				end
			end
			vim.api.nvim_buf_set_lines(0, sel_start[2] - 1, sel_end[2], false, lines)
		end)
		return "g@"
	end
end

return M

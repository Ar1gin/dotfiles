local presets = require("scripter.presets")

local M = {}

M.resolve = function(char)
	local check = string.lower(char)
	if check ~= char then
		M.upper = true
	end
	local next = M.current_script[check]
	if type(next) == "table" then
		if next.stop then
			local stopper = next.stopper
			if stopper then
				M.backlog = ""
				M.current_script = M.script
				local upper = M.upper
				M.upper = false
				return stopper[upper and 2 or 1]
			else
				M.current_script = M.script
				M.upper = false
				if M.consume then
					M.backlog = ""
					return ""
				else
					local backlog = M.backlog
					M.backlog = ""
					return backlog .. char
				end
			end
		else
			M.backlog = M.backlog .. char
			M.current_script = next
			return ""
		end
	end
	if type(next) == "nil" then
		local stopper = M.current_script.stopper
		if stopper then
			M.backlog = ""
			M.current_script = M.script
			return stopper[M.upper and 2 or 1] .. M.resolve(char)
		else
			M.current_script = M.script
			M.upper = false
			if M.consume then
				M.backlog = ""
				return ""
			else
				local backlog = M.backlog
				M.backlog = ""
				return backlog .. char
			end
		end
	end
end

M.setup = function(opts)
	M.default = opts.default or presets.none
	M.script = M.default
	M.current_script = M.default
	M.consume = opts.consume or false
	M.backlog = ""
	M.mark_namespace = vim.api.nvim_create_namespace("Scripter")
	M.mark_id = nil
	M.highlight = opts.highlight or "@comment"
	M.temporary = false
	local group = vim.api.nvim_create_augroup("Scripter", {})
	M.group = group
	vim.api.nvim_create_autocmd({ "InsertCharPre" }, {
		group = group,
		callback = function(_)
			vim.v.char = M.resolve(vim.v.char)
			M.upadte_mark()
		end
	})
	vim.api.nvim_create_autocmd({ "InsertLeavePre" }, {
		group = group,
		callback = function(_)
			M.reset()
		end
	})
end

M.disable = function()
	vim.api.nvim_buf_del_extmark(0, M.mark_namespace, M.mark_id)
	vim.api.nvim_del_augroup_by_id(M.group)
	M.group = nil
end

M.upadte_mark = function()
	if M.mark_id ~= nil then
		vim.api.nvim_buf_del_extmark(0, M.mark_namespace, M.mark_id)
		M.mark_id = nil
	end
	if M.current_script.stopper ~= nil then
		local cursor = vim.api.nvim_win_get_cursor(0)
		M.mark_id = vim.api.nvim_buf_set_extmark(
			0,
			M.mark_namespace,
			cursor[1] - 1,
			cursor[2],
			{
				virt_text = { { M.current_script.stopper[M.upper and 2 or 1], M.highlight } },
				virt_text_pos = "overlay",
			}
		)
	end
end

M.reset = function()
	if M.temporary then
		M.script = M.default
		M.temporary = false
	end
	M.current_script = M.script
	M.backlog = ""
	M.upper = false
	M.upadte_mark()
end

M.set_script = function(script, temporary)
	M.script = script
	M.current_script = script
	M.temporary = temporary
end

M.mapping = {}
M.mapping.set_script = function(script, temporary)
	return function()
		M.set_script(script, temporary)
	end
end

return M

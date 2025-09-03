local M = {}

M.autoscript = function(table)
	local output = {}
	for i = 1, #table, 3 do
		local path = table[i]
		local cmod = output
		for j = 1, string.len(path) do
			local dir = string.sub(path, j, j)
			if cmod[dir] == nil then
				cmod[dir] = { stop = string.len(path) == j }
			else
				cmod[dir].stop = false
			end
			cmod = cmod[dir]
		end
		cmod.stopper = { table[i + 1], table[i + 2] }
	end
	return output
end

return M

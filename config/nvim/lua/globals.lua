local M = {}

local create_alternate = function(border_chars)
	return {
		border_chars[2],
		border_chars[4],
		border_chars[6],
		border_chars[8],
		border_chars[1],
		border_chars[3],
		border_chars[5],
		border_chars[7],
	}
end

-- M.border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
-- M.border_chars_telescope_results = create_alternate({ "├", "─", "┤", "│", "┘", "─", "└", "│" })
-- M.border_chars_telescope_prompt = create_alternate({ "┌", "─", "┐", "│", "┤", "─", "├", "│" })

M.border_chars = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" }
M.border_chars_telescope_results = create_alternate({ "┣", "━", "┫", "┃", "┛", "━", "┗", "┃" })
M.border_chars_telescope_prompt = create_alternate({ "┏", "━", "┓", "┃", "┫", "━", "┣", "┃" })

-- M.border_chars = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }
-- M.border_chars_telescope_results = create_alternate({ "╠", "═", "╣", "║", "╝", "═", "╚", "║" })
-- M.border_chars_telescope_prompt = create_alternate({ "╔", "═", "╗", "║", "╣", "═", "╠", "║" })


M.border_chars_alternate = create_alternate(M.border_chars)

return M

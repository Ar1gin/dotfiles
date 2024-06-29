local M = {}

-- M.border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
M.border_chars = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" }
-- M.border_chars = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }

M.border_chars_alternate = {
	M.border_chars[2],
	M.border_chars[4],
	M.border_chars[6],
	M.border_chars[8],
	M.border_chars[1],
	M.border_chars[3],
	M.border_chars[5],
	M.border_chars[7],
}

return M

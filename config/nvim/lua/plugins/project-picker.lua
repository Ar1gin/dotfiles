return {
	name = "project-picker",
	dir = vim.fn.stdpath("config") .. "/lua/project-picker",
	desc = {
		{ mode = "n", "<leader>p", desc = "Open project picker" },
		{ mode = "n", "<leader>P", desc = "Edit project list" },
	},
	config = function()
		local pp = require("project-picker")
		vim.keymap.set("n", "<leader>p", pp.pick, {})
		vim.keymap.set("n", "<leader>P", pp.edit, {})
	end,
}

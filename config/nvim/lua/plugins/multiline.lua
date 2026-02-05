return {
	name = "multiline",
	dir = vim.fn.stdpath("config") .. "/lua/multiline",
	keys = {
		{ mode = { "n", "v" }, "<C-n>",  desc = "Surround with newlines" },
		{ mode = "n",          "yo",     desc = "Begin a new line below" },
		{ mode = "n",          "yO",     desc = "Begin a new line above" },
		{ mode = "n",          "<C-n>d", desc = "Remove newline surround" },
		{ mode = "n",          "<C-n>D", desc = "Remove all newline surround" },
		{ mode = "n",          "<C-n>f", desc = "Set newline surround" },
		{ mode = "v",          "<C-n>b", desc = "Break selection into a new line" },
	},
	config = function()
		local multiline = require("multiline")
		multiline.setup({})

		vim.keymap.set({ "n", "v" }, "<C-n>", multiline.surround_newlines(""), {})
		vim.keymap.set("n", "yo", multiline.next_surround("\"_S"), {})
		vim.keymap.set("n", "yO", multiline.prev_surround("\"_S"), {})
		vim.keymap.set("n", "<C-n>d", multiline.remove_surround, {})
		vim.keymap.set("n", "<C-n>D", multiline.remove_all_surround, {})
		vim.keymap.set("n", "<C-n>f", multiline.set_surround, {})
		vim.keymap.set("v", "<C-n>b", multiline.break_into_lines, {})
	end,
}

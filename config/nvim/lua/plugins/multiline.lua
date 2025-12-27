return {
	name = "multiline",
	dir = vim.fn.stdpath("config") .. "/lua/multiline",
	keys = {
		{ "<C-n>",  desc = "Surround with newlines" },
		{ "o",      desc = "Begin a new line below" },
		{ "O",      desc = "Begin a new line above" },
		{ "yo",     desc = "Begin a new line below and repeat it [count] times" },
		{ "yO",     desc = "Begin a new line above and repeat it [count] times" },
		{ "<C-n>d", desc = "Remove newline surround" },
		{ "<C-n>D", desc = "Remove all newline surround" },
		{ "<C-n>f", desc = "Set newline surround" },
		{ "<C-n>b", desc = "Break selection into a new line" },
	},
	config = function()
		local multiline = require("multiline")
		multiline.setup({})

		vim.keymap.set({ "n", "v" }, "<C-n>", multiline.surround_newlines(""), {})
		vim.keymap.set("n", "o", multiline.next_surround("\"_S"), {})
		vim.keymap.set("n", "O", multiline.prev_surround("\"_S"), {})
		vim.keymap.set("n", "yo", "o")
		vim.keymap.set("n", "yO", "O")
		vim.keymap.set("n", "<C-n>d", multiline.remove_surround, {})
		vim.keymap.set("n", "<C-n>D", multiline.remove_all_surround, {})
		vim.keymap.set("n", "<C-n>f", multiline.set_surround, {})
		vim.keymap.set("v", "<C-n>b", multiline.break_into_lines, {})
	end,
}

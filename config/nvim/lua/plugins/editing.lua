return {
	{
		name = "multiline",
		dir = vim.fn.stdpath("config") .. "/lua/multiline",
		keys = {
			{ "<C-n>",  desc = "Surround with newlines" },
			{ "o",      desc = "Open a new line below" },
			{ "O",      desc = "Open a new line above" },
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
			vim.keymap.set("n", "<C-n>d", multiline.remove_surround, {})
			vim.keymap.set("n", "<C-n>D", multiline.remove_all_surround, {})
			vim.keymap.set("n", "<C-n>f", multiline.set_surround, {})
			vim.keymap.set("v", "<C-n>b", multiline.break_into_lines, {})
		end,
	},
	{
		"tommcdo/vim-exchange",
		keys = {
			{ "cxx", desc = "Exchange line" },
			{ "cx",  desc = "Exchange motion" },
			{ "X",   desc = "Exchange selection" },
			{ "cxc", desc = "Clear exchange" },
		},
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = true,
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {},
	},
}

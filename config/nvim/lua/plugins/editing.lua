return {
	{
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
			vim.keymap.set("n", "yo", "o", { noremap = vim.v["true"] })
			vim.keymap.set("n", "yO", "O", { noremap = vim.v["true"] })
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
		"echasnovski/mini.surround",
		keys = {
			{ "ss", desc = "Surround: Add",         mode = { "n", "v" } },
			{ "sd", desc = "Surround: Delete" },
			{ "sf", desc = "Surround: Find (right)" },
			{ "sF", desc = "Surround: Find (left)" },
			{ "sr", desc = "Surround: Replace" },
		},
		opts = {
			mappings = {
				add = "ss",
				delete = "sd",
				find = "sf",
				find_left = "sF",
				highlight = "",
				replace = "sr",
				update_n_lines = "sn",
			}
		},
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"hrsh7th/nvim-insx",
		event = "InsertEnter",
		config = function()
			require('insx.preset.standard').setup({
				cmdline = { enabled = true },
				spacing = { enabled = true },
				fast_break = {
					enabled = true,
					html_attrs = true,
					arguments = true,
				},
				fast_wrap = { enabled = true },
			})
		end
	},
}

return {
	{
		name = "scripter",
		dir = vim.fn.stdpath("config") .. "/lua/scripter",
		keys = {
			{ "<leader>ss", desc = "Reset Scripter" },
			{ "<leader>sr", desc = "Set Scripter to Cyrillic" },
		},
		config = function()
			local scripter = require("scripter")
			local presets = require("scripter.presets")
			scripter.setup({
				consume = false,
			})
			vim.keymap.set("n", "<leader>ss", scripter.mapping.set_script({}))
			vim.keymap.set("n", "<leader>sr", scripter.mapping.set_script(presets.cyrillic))
			vim.keymap.set("i", "<bs>", function()
				scripter.reset()
				vim.api.nvim_feedkeys("\b", "n", false);
			end)
		end
	},
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
			vim.keymap.set("n", "yo", "o")
			vim.keymap.set("n", "yO", "O")
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
		"nmac427/guess-indent.nvim",
		lazy = false,
		keys = {
			{ "<leader>gi", "<cmd>GuessIndent<cr>", "Guess Indentation" },
		},
		opts = {
			auto_cmd = true,
			on_tab_options = {
				["expandtab"] = false,
			},
			on_space_options = {
				["expandtab"] = true,
				["tabstop"] = "detected",
				["shiftwidth"] = "detected",
			},
		},
	}
}

return {
	"akinsho/toggleterm.nvim",
	keys = {
		{ "<C-Space>",  desc = "Toggle Terminal" },
		{ "<leader>mr", "<cmd>TermExec cmd=\"make run\"<cr>",   desc = "Make (run)" },
		{ "<leader>mb", "<cmd>TermExec cmd=\"make build\"<cr>", desc = "Make (build)" },
		{ "<leader>mc", "<cmd>TermExec cmd=\"make clean\"<cr>", desc = "Make (clean)" },
		{ "<leader>mt", "<cmd>TermExec cmd=\"make test\"<cr>",  desc = "Make (test)" },
	},
	opts = {
		autochdir = true,
		open_mapping = "<C-Space>",
		direction = "float",
		shade_terminals = false,
		float_opts = {
			border = require("globals").border_chars,
		},
		highlights = {
			["FloatBorder"] = {
				link = "FloatBorder"
			}
		},
	},
}

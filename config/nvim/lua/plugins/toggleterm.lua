return {
	"akinsho/toggleterm.nvim",
	keys = {
		{ "<C-Space>",  desc = "Toggle Terminal" },
	},
	opts = {
		autochdir = false,
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

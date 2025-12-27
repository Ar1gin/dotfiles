return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			border = require("globals").border_chars,
		},
		select = {
			builtin = {
				border = require("globals").border_chars,
			},
		},
	},
}

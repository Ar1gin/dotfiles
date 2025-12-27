return {
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

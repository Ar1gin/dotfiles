return {
	"nmac427/guess-indent.nvim",
	lazy = false,
	keys = {
		{ "<leader>ig", "<cmd>GuessIndent<cr>", desc = "Guess Indentation" },
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

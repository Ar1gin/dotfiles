local log_short = "Git log --graph --abbrev-commit --decorate --format=format:'%h - (%ar) %s - %an%d'"
local log_long = "Git log --graph --abbrev-commit --decorate --format=format:'%h - %aD (%ar)%d%n    %s - %an%n'"

return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>gfc", "<cmd>Git commit<cr>",          desc = "Git commit" },
		{ "<leader>gfs", "<cmd>Git<cr>",                 desc = "Git status" },
		{ "<leader>gfb", "<cmd>Git blame<cr>",           desc = "Git blame" },
		{ "<leader>gfl", "<cmd>" .. log_short .. "<cr>", desc = "Git log" },
		{ "<leader>gfL", "<cmd>" .. log_long .. "<cr>",  desc = "Git log" },
	},
}

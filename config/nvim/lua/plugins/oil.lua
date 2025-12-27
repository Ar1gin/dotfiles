return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>e", "<cmd>Oil<cr>",    desc = "File Explorer" },
		{ "<leader>E", "<cmd>Oil ./<cr>", desc = "CWD Explorer" },
	},
	opts = {},
}

return {
	"moll/vim-bbye",
	keys = {
		{ "<leader>bd", "<cmd>Bdelete<cr>",    desc = "Delete current buffer" },
		{ "<leader>bD", "<cmd>Bwipeout<cr>",   desc = "Delete all buffers" },
		{ "<leader>bc", desc = "Clean buffers" }, -- TODO: Implement the thing
	},
}

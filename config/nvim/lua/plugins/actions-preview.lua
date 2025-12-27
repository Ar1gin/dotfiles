return {
	"aznhe21/actions-preview.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{ "gra", desc = "Code Actions" },
	},
	config = function()
		require("actions-preview").setup({
			diff = {
				ctxlen = 2,
				algorithm = "histogram",
			},
			backend = { "telescope" },
			telescope = {
				sorting_strategy = "ascending",
				layout_strategy = "cursor",
				layout_config = {
					preview_width = 0.6,
					width = 0.8,
					height = 16,
				},
			},
		})
		vim.keymap.set({ "n", "v" }, "gra", require("actions-preview").code_actions)
	end,
}

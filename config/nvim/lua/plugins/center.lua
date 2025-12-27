return {
	name = "center",
	dir = vim.fn.stdpath("config") .. "/lua/center",
	config = function()
		require("center").setup({
			enabled = true,
			skip_filetypes = {
				"buffer_manager",
			},
		})
	end,
}

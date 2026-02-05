return {
	name = "center",
	dir = vim.fn.stdpath("config") .. "/lua/center",
	event = "VeryLazy",
	keys = {
		{ mode = "n", "<leader>vc", desc = "Toggle vertical centering" },
	},
	config = function()
		local center = require("center")
		center.setup({
			enabled = true,
			skip_filetypes = {
				"buffer_manager",
			},
		})
		vim.keymap.set("n", "<leader>vc", function() center.toggle() end)
	end,
}

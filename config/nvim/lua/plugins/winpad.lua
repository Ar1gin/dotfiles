return {
	name = "winpad",
	dir = vim.fn.stdpath("config") .. "/lua/winpad",
	config = function()
		local winpad = require("winpad")
		winpad.setup({
			enabled = true,
			pad_min_width = 100,
		})
		vim.keymap.set("n", "<leader>x", winpad.toggle, { desc = "Toggle Window Padding" })
	end,
}

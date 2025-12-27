return {
	name = "scripter",
	dir = vim.fn.stdpath("config") .. "/lua/scripter",
	keys = {
		{ "<leader>ss", desc = "Reset Scripter" },
		{ "<leader>sr", desc = "Temporarily Set Scripter to Cyrillic" },
		{ "<leader>sR", desc = "Set Scripter to Cyrillic" },
	},
	config = function()
		local scripter = require("scripter")
		local presets = require("scripter.presets")
		scripter.setup({
			consume = false,
		})
		vim.keymap.set("n", "<leader>ss", scripter.mapping.set_script({}))
		vim.keymap.set("n", "<leader>sr", scripter.mapping.set_script(presets.cyrillic, true))
		vim.keymap.set("n", "<leader>sR", scripter.mapping.set_script(presets.cyrillic, false))
		vim.keymap.set("i", "<bs>", function()
			scripter.reset()
			vim.api.nvim_feedkeys("\b", "n", false);
		end)
	end,
}

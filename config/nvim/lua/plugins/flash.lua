return {
	"folke/flash.nvim",
	keys = {
		{ "<cr>",                   mode = { "n", "x", "o" }, desc = "Search in visible text" },
		{ mode = { "x", "o" },      "z",                      desc = "Treesitter incremental search" },
		{ mode = { "n", "x", "o" }, "f" },
		{ mode = { "n", "x", "o" }, "F" },
		{ mode = { "n", "x", "o" }, "t" },
		{ mode = { "n", "x", "o" }, "T" },
	},
	config = function()
		local flash = require("flash")
		flash.setup({
			search = {
				mode = "fuzzy",
			},
			label = {
				uppercase = false,
			},
			modes = {
				treesitter = {
					labels = "",
				},
			},
		})

		vim.keymap.set({ "n", "x", "o" }, "<cr>", flash.jump)
		vim.keymap.set({ "x", "o" }, "z", function()
			flash.treesitter({
				actions = {
					["z"] = "next",
					["Z"] = "prev",
				},
			})
		end)
	end,
}

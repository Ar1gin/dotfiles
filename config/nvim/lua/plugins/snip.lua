return {
	"L3MON4D3/LuaSnip",
	keys = {
		{ "<C-q>", desc = "Expand Snippet", mode = "i" },
	},
	config = function()
		local ls = require("luasnip")

		vim.keymap.set({ "i", "s" }, "<C-q>", function() ls.expand_or_jump() end, { silent = true })
		-- vim.keymap.set({ "i", "s" }, "<Tab>", function() ls.jump(1) end, { silent = true })
		-- vim.keymap.set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<Tab>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			else
				return "\t"
			end
		end, { silent = true })

		ls.setup({
			link_roots = true,
			keep_roots = true,
			delete_check_events = "TextChanged",
		})

		require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath('config') .. "/snippets" })
	end,
}

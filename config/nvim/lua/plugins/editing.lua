return {
	{
		name = "case",
		dir = "case",
		keys = {
			{ "gsp", mode = { "n", "v" }, desc = "Change to PascalCase" },
			{ "gss", mode = { "n", "v" }, desc = "Change to snake_case" },
			{ "gsk", mode = { "n", "v" }, desc = "Change to kebab-case" },
			{ "gsc", mode = { "n", "v" }, desc = "Change to camelCase" },
			{ "gsu", mode = { "n", "v" }, desc = "Change to UPPER_CASE" },
		},
		config = function()
			local case = require("case")
			vim.keymap.set({ "n", "v" }, "gsp", case.convert_case("pascal"), { expr = true })
			vim.keymap.set({ "n", "v" }, "gss", case.convert_case("snake"), { expr = true })
			vim.keymap.set({ "n", "v" }, "gsk", case.convert_case("kebab"), { expr = true })
			vim.keymap.set({ "n", "v" }, "gsc", case.convert_case("camel"), { expr = true })
			vim.keymap.set({ "n", "v" }, "gsu", case.convert_case("upper"), { expr = true })
		end,
	},
	{
		name = "multiline",
		dir = "multiline",
		keys = {
			{ "<C-n>",  desc = "Surround with newlines" },
			{ "o",      desc = "Open a new line below" },
			{ "O",      desc = "Open a new line above" },
			{ "<C-n>d", desc = "Remove newline surround" },
			{ "<C-n>D", desc = "Remove all newline surround" },
			{ "<C-n>f", desc = "Set newline surround" },
			{ "<C-n>b", desc = "Break selection into a new line" },
		},
		config = function()
			local multiline = require("multiline")
			multiline.setup({})

			vim.keymap.set({ "n", "v" }, "<C-n>", multiline.surround_newlines(""), {})
			vim.keymap.set("n", "o", multiline.next_surround("S"), {})
			vim.keymap.set("n", "O", multiline.prev_surround("S"), {})
			vim.keymap.set("n", "<C-n>d", multiline.remove_surround, {})
			vim.keymap.set("n", "<C-n>D", multiline.remove_all_surround, {})
			vim.keymap.set("n", "<C-n>f", multiline.set_surround, {})
			vim.keymap.set("v", "<C-n>b", multiline.break_into_lines, {})
		end,
	},
	{
		"tommcdo/vim-exchange",
		-- cxx: exchange line
		-- cx<motion>: exchange motion
		-- X: exchange selection
		-- cxc: clear exchange
	},
	{
		"kylechui/nvim-surround",
		config = true,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = true,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local pairs = require("nvim-autopairs")
			pairs.setup({})
			local rule = require("nvim-autopairs.rule")
			local ts_conds = require("nvim-autopairs.ts-conds")
			local conds = require("nvim-autopairs.conds")
			-- IT DOES NOT WORK AAHHHHHHHHH!!
			-- TS doesn't mark `T<` as a generic type node
			-- until the syntax is correct like `T<X>` which is what I am trying to automate!!
			pairs.add_rule(
				rule("<", ">", "rust")
				:with_pair(ts_conds.is_ts_node(
					{
						"type_identifier",
						"generic_type",
						"type_arguments",
						"scoped_identifier",
					}
				))
				:with_move(conds.move_right())
			)
			pairs.add_rule(
				rule("<", ">", "rust")
				:with_pair(conds.before_text("::"))
				:with_move(conds.move_right())
			)
		end,
	},
}

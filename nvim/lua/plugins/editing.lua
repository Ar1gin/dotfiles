return {
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

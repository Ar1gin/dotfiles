return {
	{
		"xiaoshihou514/squirrel.nvim",
		keys = {
			{ "M", desc = "Hop" },
		},
		config = function()
			require("squirrel.utils").key_iter.keys = "hfjdksla"
			vim.keymap.set({ "n", "v" }, "M", function()
				vim.cmd(".mark '")
				require("squirrel.hop").hop()
			end)
		end,
	},
	{
		"ggandor/leap.nvim",
		keys = {
			{ "<C-m>", "<Plug>(leap)", desc = "Leap" },
		},
		config = function()
			local leap = require("leap")
			leap.opts.safe_lables = ""
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		main = "nvim-treesitter.configs",
		config = function()
			local move_actions = {
				["f"] = "function",
				["c"] = "class",
				["r"] = "return",
				["p"] = "parameter",
				["a"] = "attribute",
				["d"] = "comment",
			}
			local goto_next_start = {}
			local goto_next_end = {}
			local goto_previous_start = {}
			local goto_previous_end = {}
			for letter, action in pairs(move_actions) do
				local letter_lower = string.lower(letter)
				local letter_upper = string.upper(letter)
				goto_next_start["]" .. letter_lower] = {
					query = string.format("@%s.outer", action),
					desc = string.format("Next %s start", action),
				}
				goto_next_end["]" .. letter_upper] = {
					query = string.format("@%s.outer", action),
					desc = string.format("Next %s end", action),
				}
				goto_previous_start["[" .. letter_lower] = {
					query = string.format("@%s.outer", action),
					desc = string.format("Previous %s start", action),
				}
				goto_previous_end["[" .. letter_upper] = {
					query = string.format("@%s.outer", action),
					desc = string.format("Previous %s end", action),
				}
			end
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aF"] = { query = "@function.outer", desc = "function" },
							["iF"] = { query = "@function.inner", desc = "function" },
							["aT"] = { query = "@class.outer", desc = "type" },
							["iT"] = { query = "@class.inner", desc = "type" },
							["iA"] = { query = "@assignment.lhs", desc = "assignment" },
							["aA"] = { query = "@assignment.rhs", desc = "assignment" },
							["aP"] = { query = "@parameter.outer", desc = "parameter" },
							["iP"] = { query = "@parameter.inner", desc = "parameter" },
							["aC"] = { query = "@call.outer", desc = "call" },
							["iC"] = { query = "@call.inner", desc = "call" },
							["aD"] = { query = "@comment.outer", desc = "comment" },
							["iD"] = { query = "@comment.inner", desc = "comment" },
						},
						include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = goto_next_start,
						goto_next_end = goto_next_end,
						goto_previous_start = goto_previous_start,
						goto_previous_end = goto_previous_end,
					},
				},
			})
		end,
	},
}

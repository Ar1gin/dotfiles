return {
	{
		"xiaoshihou514/squirrel.nvim",
		keys = {
			{ "M", desc = "Hop" },
		},
		config = function()
			vim.keymap.set({ "n", "v" }, "M", require("squirrel.hop").hop)
		end,
	},
	{
		"ggandor/leap.nvim",
		keys = {
			{ "m", "<Plug>(leap)", desc = "Leap" },
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
							["af"] = { query = "@function.outer", desc = "function" },
							["if"] = { query = "@function.inner", desc = "function" },
							["at"] = { query = "@class.outer", desc = "type" },
							["it"] = { query = "@class.inner", desc = "type" },
							["ia"] = { query = "@assignment.lhs", desc = "assignment" },
							["aa"] = { query = "@assignment.rhs", desc = "assignment" },
							["ap"] = { query = "@parameter.outer", desc = "parameter" },
							["ip"] = { query = "@parameter.inner", desc = "parameter" },
							["ac"] = { query = "@call.outer", desc = "call" },
							["ic"] = { query = "@call.inner", desc = "call" },
							["ad"] = { query = "@comment.outer", desc = "comment" },
							["id"] = { query = "@comment.inner", desc = "comment" },
						},
						include_surrounding_whitespace = true,
					},
					move = {
						enable = true,
						goto_next_start = goto_next_start,
						goto_next_end = goto_next_end,
						goto_previous_start = goto_previous_start,
						goto_previous_end = goto_previous_end,
					},
				},
			})
			local ts_repeat = require("nvim-treesitter.textobjects.repeatable_move")
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous)
		end,
	},
}

return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1024,
		config = function()
			local transparent = true
			local color_overrides = {}
			if transparent then
				color_overrides = { theme = { all = { ui = { bg_gutter = "NONE" } } } }
			end
			require("kanagawa").setup({
				transparent = transparent,
				compile = false,
				undercurl = false,
				commentStyle = { italic = false, bold = false },
				keywordStyle = { italic = false, bold = false },
				statementStyle = { italic = false, bold = false },
				colors = color_overrides,
				overrides = function(colors)
					return {
						["Boolean"] = { bold = false },
						["Todo"] = { bold = false },
						["@variable.builtin"] = { italic = false },
						["@string.escape"] = { bold = false },
						["@keyword.operator"] = { bold = false },
						["@comment.error"] = { bold = false },
						["@comment.warning"] = { bold = false },
						["@comment.note"] = { bold = false },
						["Conceal"] = { bold = false },
						["CursorLineNr"] = { bold = false },
						["CurSearch"] = { bold = false },
						["MatchParen"] = { bold = false },
						["ModeMsg"] = { bold = false },
						["FloatTitle"] = { bold = false },
						["Title"] = { bold = false },
						["LinePad"] = { fg = colors.theme.ui.nontext, bg = colors.theme.ui.bg_gutter },
						["FloatBorder"] = { fg = colors.theme.ui.float.fg_border, bg = not transparent and colors.theme.ui.bg or "NONE" },
						["CmdlineCommand"] = { fg = colors.theme.diag.warning, bg = colors.theme.ui.bg },
						["Pmenu"] = { bg = colors.theme.ui.bg_m3 },
						["PmenuSbar"] = { bg = colors.theme.ui.bg_m1 },
						["PmenuThumb"] = { bg = colors.theme.term[9] },
						["PmenuSel"] = { bg = colors.theme.bg_visual },
						["NormalFloat"] = { bg = not transparent and colors.theme.ui.float.bg or "NONE" },
						["IndentWhitespace"] = { fg = "#303030" },
					}
				end,
			})
			local termcolors = {
				"#282A2E",
				"#A54242",
				"#8C9440",
				"#DE935F",
				"#5F819D",
				"#85678F",
				"#5E8D87",
				"#707880",
				"#373B41",
				"#FF5555",
				"#B5BD68",
				"#F0C674",
				"#81A2BE",
				"#B294BB",
				"#8ABEB7",
				"#C5C8C6",
			}
			vim.cmd("colorscheme kanagawa-wave")
			for i, color in ipairs(termcolors) do
				vim.g["terminal_color_" .. i - 1] = color
			end
			vim.cmd([[match WrongWhitespace /\s\+$/]])
			vim.api.nvim_set_hl(0, "WrongWhitespace", { bg = "#FF0000" })
			vim.api.nvim_set_hl(0, "ExchangeRegion", { link = "CursorLine" })
		end,
	},
}

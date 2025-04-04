return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1024,
		config = function()
			local transparent = true
			if vim.g.neovide then
				transparent = false
			end
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
						["Whitespace"] = { fg = "#606060" },
						["NonText"] = { fg = "#606060" },
						-- Markdown
						["RenderMarkdownUnchecked"] = { fg = "#54546d" },
						["RenderMarkdownChecked"] = { fg = "#54546D" },
						["RenderMarkdownWip"] = { fg = "#7FB4CA" },
						["RenderMarkdownCanceled"] = { fg = "#54546D" },
						["RenderMarkdownImportant"] = { fg = "#FFA066" },
						["RenderMarkdownUnknown"] = { fg = "#727169" },
						["RenderMarkdownIdea"] = { fg = "#FFA066" },
						["RenderMarkdownStar"] = { fg = "#FFA066" },
						["RenderMarkdownPositive"] = { link = "@diff.plus" },
						["RenderMarkdownNegative"] = { link = "@diff.minus" },
						["RenderMarkdownCheckedScope"] = { fg = "#54546D", strikethrough = true },
						["RenderMarkdownH1"] = { fg = "#957FB8", bg = "#2A2A37" },
						["RenderMarkdownH1Bg"] = { fg = "#957FB8", bg = "#2A2A37" },
						["RenderMarkdownH2"] = { fg = "#98BB6C", bg = "#2A2A37" },
						["RenderMarkdownH2Bg"] = { fg = "#98BB6C", bg = "#2A2A37" },
						["RenderMarkdownH3"] = { fg = "#7FB4CA", bg = "#2A2A37" },
						["RenderMarkdownH3Bg"] = { fg = "#7FB4CA", bg = "#2A2A37" },
						["RenderMarkdownH4"] = { fg = "#7FB4CA", bg = "#2A2A37" },
						["RenderMarkdownH4Bg"] = { fg = "#7FB4CA", bg = "#2A2A37" },
						["RenderMarkdownH5"] = { fg = "#7FB4CA", bg = "#2A2A37" },
						["RenderMarkdownH5Bg"] = { fg = "#7FB4CA", bg = "#2A2A37" },
						["RenderMarkdownH6"] = { fg = "#7FB4CA", bg = "#2A2A37" },
						["RenderMarkdownH6Bg"] = { fg = "#7FB4CA", bg = "#2A2A37" },
						["RenderMarkdownCode"] = { bg = "#24252D" },
						["RenderMarkdownCodeInline"] = { bg = "#24252D" },
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
			vim.api.nvim_set_hl(0, "ExchangeRegion", { link = "CursorLine" })
		end,
	},
}

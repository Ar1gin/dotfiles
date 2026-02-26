return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1024,
	build = ":KanagawaCompile",
	config = function()
		local transparent = false

		require("kanagawa").setup({
			transparent = transparent,
			compile = true,
			undercurl = false,
			commentStyle = { italic = true, bold = false },
			keywordStyle = { italic = false, bold = true },
			statementStyle = { italic = false, bold = false },
			typeStyle = { italic = false, bold = false },
			colors = { theme = { all = { ui = { bg_gutter = "NONE" } } } },
			overrides = function(colors)
				return {
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
					-- Lualine
					["TabActive"] = { fg = colors.theme.ui.fg, bg = colors.theme.ui.bg_p2 },
					["TabInactive"] = { fg = colors.theme.ui.fg_dim, bg = colors.theme.ui.bg_m1 },
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
		vim.cmd("colorscheme kanagawa-dragon")
		for i, color in ipairs(termcolors) do
			vim.g["terminal_color_" .. i - 1] = color
		end
		vim.api.nvim_set_hl(0, "ExchangeRegion", { link = "CursorLine" })
	end,
}

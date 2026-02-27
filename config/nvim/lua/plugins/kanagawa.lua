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

		vim.cmd("colorscheme kanagawa-dragon")

		local termcolors = {
			"#202226",
			"#9D3A3A",
			"#848C38",
			"#D68B57",
			"#577995",
			"#7D5F87",
			"#56857F",
			"#687078",
			"#272B31",
			"#EF4545",
			"#A5AD58",
			"#E0B664",
			"#7192AE",
			"#A284AB",
			"#7AAEA7",
			"#B5B8B6",
		}
		for i, color in ipairs(termcolors) do
			vim.g["terminal_color_" .. i - 1] = color
		end
	end,
}

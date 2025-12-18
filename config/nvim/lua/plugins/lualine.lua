local lualine_pad = {
	"",
	separator = { left = "", right = "" },
	padding = 0,
	color = "Normal",
	fmt = function(input, context)
		-- Lualine does not provide `tabnr` sometimes for unknown reason
		local tabnr = context.tabnr or 0
		if tabnr == 0 then
			return ""
		end
		local winnr = vim.fn.tabpagewinnr(context.tabnr)

		if winnr == 0 then
			return ""
		end
		return string.rep("⠀", require("winpad").get_pad_size(winnr)) .. input
	end
}

return {
	{
		"letieu/harpoon-lualine",
		dependencies = {
			{
				"ThePrimeagen/harpoon",
				branch = "harpoon2",
			}
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"winpad",
			"letieu/harpoon-lualine",
		},
		config = true,
		opts = {
			options = {
				theme = "auto",
				refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
				section_separators = { left = "▌", right = "▐" },
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					lualine_pad,
					{
						"mode",
						separator = { left = "" },
					},
				},
				lualine_b = { "filename", "diff" },
				lualine_c = {},
				lualine_x = {
					{
						"harpoon2",
						icon = "󰀱",
						indicators = { "1", "2", "3", "4", "5" },
						active_indicators = { "1", "2", "3", "4", "5" },
						color = { fg = "#a0a0c0" },
						color_active = { fg = "#fc6346" },
					},
					-- It's him! The legendary cat2!
					{ function() return "🐈" end }, "diagnostics"
				},
				lualine_y = { "branch" },
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = { lualine_pad },
				lualine_b = { "filename" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { function() return "👀" end },
			},
		},
	}
}

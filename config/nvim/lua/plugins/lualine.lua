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
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"winpad",
		},
		config = true,
		opts = {
			options = {
				theme = "auto",
				refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
				-- section_separators = { left = "▌", right = "▐" },
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				always_show_tabline = false,
			},
			tabline = {
				lualine_a = {
					{
						"tabs",
						mode = 1,
						path = 1,
						tab_max_length = 16,
						fmt = function(name, context)
							return context.tabnr .. ": " .. name
						end
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
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
					"diagnostics",
					-- It's him! The legendary cat2!
					{ function() return "🐈" end },
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

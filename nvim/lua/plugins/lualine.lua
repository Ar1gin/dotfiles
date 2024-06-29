local lualine_pad = {
	"",
	separator = { left = "", right = "" },
	padding = 0,
	color = "Normal",
	fmt = function(input, context)
		local winnr = vim.fn.tabpagewinnr(context.tabnr)
		return string.rep("⠀", require("winpad").get_pad_size(winnr)) .. input
	end
}
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "winpad" },
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
			-- It's him! The legendary cat2!
			lualine_x = { { function() return "🐈" end }, "diagnostics" },
			lualine_y = { "branch" },
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = { lualine_pad },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { function() return "👀" end },
		},
	},
}

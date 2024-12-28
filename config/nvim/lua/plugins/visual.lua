return {
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
			vim.api.nvim_create_autocmd({ "BufNew", "VimEnter" }, {
				callback = function(ev)
					require("colorizer").attach_to_buffer(ev.buf)
				end
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		name = "center",
		dir = vim.fn.stdpath("config") .. "/lua/center",
		config = function()
			require("center").setup({
				enabled = true,
				skip_filetypes = {
					"buffer_manager",
				},
			})
		end
	},
	{
		"stevearc/dressing.nvim",
		opts = {
			input = {
				border = require("globals").border_chars,
			},
			select = {
				builtin = {
					border = require("globals").border_chars,
				},
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = {
			color_icons = true,
			default = true,
		},
	},
}

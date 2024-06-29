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
		"b0o/incline.nvim",
		dependencies = { "j-morano/buffer_manager.nvim" },
		config = function()
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = {
					placement = {
						vertical = "top",
						horizontal = "right",
					},
					padding = 0,
					margin = { vertical = 0, horizontal = 0 },
					width = "fit",
					overlap = { tabline = true, winbar = false, borders = false, statusline = false },
				},
				hide = {
					cursorline = false,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")
					if filename == "" then
						filename = "[Scratch]"
					end
					local ft_icon, ft_color = devicons.get_icon_color(filename)
					local buffers = {}

					-- FIXME: Broken! And I have no idea why!
					for i, mark in pairs(require("buffer_manager").marks) do
						local is_main = mark.buf_id == props.buf
						local color = is_main and "#FFA066" or "Normal"
						table.insert(buffers, {
							((i == 1) and " " or "") .. (is_main and "󰫈" or "󰋙") .. " ",
							guifg = color,
						})
					end

					return {
						{ " " .. filename .. " " },
						{ " " .. ft_icon .. " ", guifg = "#000000", guibg = ft_color },
						buffers,
					}
				end,
			})
		end,
		event = "VeryLazy",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = false },
			indent = { char = "│" },
		},
	},
	{
		"arnamak/stay-centered.nvim",
		opts = {
			enabled = true
		},
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

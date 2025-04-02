return {
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ "<C-Space>",  desc = "Toggle Terminal" },
			{ "<leader>mr", "<cmd>TermExec cmd=\"make run\"<cr>",   desc = "Make (run)" },
			{ "<leader>mb", "<cmd>TermExec cmd=\"make build\"<cr>", desc = "Make (build)" },
			{ "<leader>mc", "<cmd>TermExec cmd=\"make clean\"<cr>", desc = "Make (clean)" },
			{ "<leader>mt", "<cmd>TermExec cmd=\"make test\"<cr>",  desc = "Make (test)" },
		},
		opts = {
			autochdir = true,
			open_mapping = "<C-Space>",
			direction = "float",
			shade_terminals = false,
			float_opts = {
				border = require("globals").border_chars,
			},
			highlights = {
				["FloatBorder"] = {
					link = "FloatBorder"
				}
			},
		},
	},
	{
		name = "winpad",
		dir = vim.fn.stdpath("config") .. "/lua/winpad",
		config = function()
			local winpad = require("winpad")
			winpad.setup({
				enabled = true,
			})
			vim.keymap.set("n", "<leader>x", winpad.toggle, { desc = "Toggle Window Padding" })
		end
	},
	{
		"backdround/global-note.nvim",
		keys = {
			{ "<leader>n", "<cmd>ProjectNote<cr>", desc = "Project Note" },
			{ "<leader>N", "<cmd>GlobalNote<cr>",  desc = "Global Note" },
		},
		config = function()
			local global_note = require("global-note")
			global_note.setup({
				title = "Global Note",
				directory = "~/Documents/Notes/Repos",
				filename = "global_note.md",
				command_name = "GlobalNote",
				window_config = function()
					local window_height = vim.api.nvim_list_uis()[1].height
					local window_width = vim.api.nvim_list_uis()[1].width
					return {
						relative = "editor",
						border = require("globals").border_chars,
						title = "Note",
						title_pos = "center",
						width = math.floor(0.7 * window_width),
						height = math.floor(0.85 * window_height),
						row = math.floor(0.05 * window_height),
						col = math.floor(0.15 * window_width),
					}
				end,
				additional_presets = {
					project = {
						title = "Project Note",
						command_name = "ProjectNote",
						filename = function()
							local repo = vim.system({
								"git",
								"rev-parse",
								"--show-toplevel",
							}, {
								text = true,
							}):wait()
							if repo.stderr ~= "" then
								vim.notify(repo.stderr, vim.log.levels.WARN)
								return nil
							end

							local project_name = vim.fs.basename(repo.stdout:gsub("\n", ""))
							if project_name == nil then
								vim.notify("Unable to get project name ", vim.log.levels.WARN)
								return nil
							end

							return project_name .. ".md"
						end,
					}
				},
			})
		end
	},
	{
		"moll/vim-bbye",
		keys = {
			{ "<leader>bd", "<cmd>Bdelete<cr>",    desc = "Delete current buffer" },
			{ "<leader>bD", "<cmd>Bwipeout<cr>",   desc = "Delete all buffers" },
			{ "<leader>bc", desc = "Clean buffers" }, -- TODO: Implement the thing
		},
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>e", "<cmd>Oil<cr>",    desc = "File Explorer" },
			{ "<leader>E", "<cmd>Oil ./<cr>", desc = "CWD Explorer" },
		},
		opts = {},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>za", desc = "Add buffer to harpoon" },
			{ "<leader>zs", desc = "Seek harpoon buffers" },
			{ "<leader>zd", desc = "Remove buffer from harpoon" },
			{ "<leader>zx", desc = "Previous harpoon buffer" },
			{ "<leader>zc", desc = "Next harpoon buffer" },
			{ "<leader>1" },
			{ "<leader>2" },
			{ "<leader>3" },
			{ "<leader>4" },
		},
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({
				settings = { save_on_ui_close = true, save_on_toggle = true },
			})
			vim.keymap.set("n", "<leader>za", function() harpoon:list():add() end)
			vim.keymap.set("n", "<leader>zs",
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list(), {
						border = require("globals").border_chars,
						title = " Buffers ",
						title_pos = "center",
					})
				end)
			vim.keymap.set("n", "<leader>zd", function() harpoon:list():remove() end)
			vim.keymap.set("n", "<leader>zx", function() harpoon:list():prev() end)
			vim.keymap.set("n", "<leader>zc", function() harpoon:list():next() end)
			local keys = "1234567890"
			for i = 1, #keys do
				local key = keys:sub(i, i)
				vim.keymap.set("n", string.format("<leader>%s", key), function()
					harpoon:list():select(i)
				end)
			end
			harpoon:extend({
				UI_CREATE = function(cx)
					for i = 1, #keys do
						local key = keys:sub(i, i)
						vim.keymap.set("n", key, function()
							harpoon:list():select(i)
						end, { buffer = cx.bufnr })
					end
					vim.keymap.set("n", "<C-v>", function()
						harpoon.ui:select_menu_item({ vsplit = true })
					end, { buffer = cx.bufnr })
					vim.keymap.set("n", "<C-s>", function()
						harpoon.ui:select_menu_item({ split = true })
					end, { buffer = cx.bufnr })
				end,
			})
		end,
	}
}

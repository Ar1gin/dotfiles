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
			{ "<leader>nn", "<cmd>ProjectNote<cr>", desc = "Project Note" },
			{ "<leader>nf", "<cmd>FileNote<cr>",    desc = "File Note" },
			{ "<leader>N",  "<cmd>GlobalNote<cr>",  desc = "Global Note" },
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
					},
					file = {
						title = "File Note",
						command_name = "FileNote",
						directory = vim.fn.getcwd,
						filename = "notes.md",
					},
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
}

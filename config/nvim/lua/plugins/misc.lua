return {
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ "<C-\\>", desc = "Toggle Terminal" },
		},
		opts = {
			autochdir = true,
			open_mapping = "<C-\\>",
			direction = "float",
			shade_terminals = false,
		},
	},
	{
		name = "winpad",
		dir = "winpad", -- TODO: Upload the plugin somewhere
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
				directory = "~/Projects/Notes/Repos",
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
		"j-morano/buffer_manager.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>z", desc = "Buffer Quick Menu" },
		},
		config = function()
			require("buffer_manager").setup({
				-- Plenary's windows have `Normal` highlight
				highlight = "Normal:FloatBorder",
				borderchars = require("globals").border_chars_alternate,
				format_function = function(fname)
					local bufnr = vim.fn.bufnr(fname)
					fname = vim.fn.fnamemodify(fname, ":~:.") .. " "
					if bufnr ~= -1 and vim.fn.buflisted(bufnr) == 1 then
						local diagnostics = vim.diagnostic.get(bufnr)
						local count = { 0, 0, 0, 0 }
						for _, diagnostic in ipairs(diagnostics) do
							if vim.startswith(vim.diagnostic.get_namespace(diagnostic.namespace).name, "vim.lsp") then
								count[diagnostic.severity] = count[diagnostic.severity] + 1
							end
						end
						local left = 5
						if count[vim.diagnostic.severity.ERROR] > 0 then
							local chars = math.min(left, count[vim.diagnostic.severity.ERROR])
							fname = fname .. string.rep("🐈", chars)
							left = left - chars
							return fname
						end
						if count[vim.diagnostic.severity.WARN] > 0 then
							local chars = math.min(left, count[vim.diagnostic.severity.WARN])
							fname = fname .. string.rep("🔪", chars)
							left = left - chars
						end
						if count[vim.diagnostic.severity.INFO] > 0 then
							local chars = math.min(left, count[vim.diagnostic.severity.INFO])
							fname = fname .. string.rep("🤔", chars)
							left = left - chars
						end
						if count[vim.diagnostic.severity.HINT] > 0 then
							local chars = math.min(left, count[vim.diagnostic.severity.HINT])
							fname = fname .. string.rep("⭐", chars)
							left = left - chars
						end
					end
					return fname
				end,
			})
			vim.keymap.set("n", "<leader>z", require("buffer_manager.ui").toggle_quick_menu)
			local b_ui = require("buffer_manager.ui")
			local keys = "1234567890"
			for i = 1, #keys do
				local key = keys:sub(i, i)
				vim.keymap.set("n", "<leader>" .. key, function()
					b_ui.nav_file(i)
				end)
			end
		end
	},
}

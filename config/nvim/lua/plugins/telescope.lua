return {
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		keys = {
			{ "<leader>t",  desc = "Resume Search" },
			{ "<leader>f",  desc = "Find All Files" },
			{ "<leader>F",  desc = "Find Git Files" },
			{ "<leader>/",  desc = "FZF In File" },
			{ "<leader>G",  desc = "Grep Text" },
			{ "<leader>Z",  desc = "Buffer Telescope Menu" },
			{ "<leader>d",  desc = "Local Diagnostics" },
			{ "<leader>D",  desc = "Global Diagnostics" },
			{ "<leader>gc", desc = "List Commits" },
			{ "<leader>gC", desc = "List All Commits" },
			{ "<leader>gs", desc = "Git Status" },
			{ "<leader>hk", desc = "Search keymaps" },
			{ "gO",         desc = "Local Symbols" },
			{ "gS",         desc = "Global Symbols" },
			{ "grr",        desc = "References" },
			{ "gri",        desc = "Definitions" },
		},
		config = function()
			local actions = require("telescope.actions")

			require('telescope.pickers.layout_strategies').horizontal_merged =
				function(picker, max_columns, max_lines, layout_config)
					local layout = require('telescope.pickers.layout_strategies').horizontal(picker, max_columns,
						max_lines,
						layout_config)
					local overdraw_chars = require("globals").border_chars_joined

					layout.results.line = layout.results.line - 1
					layout.results.height = layout.results.height + 1
					layout.results.title = ''
					layout.results.borderchars = require("globals").border_chars_telescope_results

					layout.prompt.borderchars = require("globals").border_chars_telescope_prompt

					if layout.preview then
						layout.preview.title = ''
					end
					return layout
				end

			require("telescope").setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = "👉",
					sorting_strategy = "ascending",
					layout_config = {
						width = 0.90,
						height = 0.90,
						prompt_position = "top",
						preview_width = 0.5,
					},
					layout_strategy = "horizontal_merged",
					wrap_results = true,
					borderchars = require("globals").border_chars_alternate,
					default_mappings = {
						n = {
							["<Esc>"] = actions.close,
							-- QWERTY mappings
							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["h"] = actions.select_default,
							["l"] = actions.close,
							["H"] = actions.move_to_top,
							["L"] = actions.move_to_bottom,
							["<M-j>"] = actions.preview_scrolling_down,
							["<M-k>"] = actions.preview_scrolling_up,
							["<M-h>"] = actions.preview_scrolling_left,
							["<M-l>"] = actions.preview_scrolling_right,
							-- Colemak mappings
							["n"] = actions.select_default,
							["e"] = actions.move_selection_next,
							-- Yes, use `a`
							["i"] = actions.move_selection_previous,
							["o"] = actions.close,
							["N"] = actions.move_to_top,
							["O"] = actions.move_to_bottom,
							["<M-e>"] = actions.preview_scrolling_down,
							["<M-i>"] = actions.preview_scrolling_up,
							["<M-n>"] = actions.preview_scrolling_left,
							["<M-o>"] = actions.preview_scrolling_right,
						},
						i = {
							["<Esc>"] = false,
							["<C-c>"] = false,
							-- QWERTY mappings
							["<C-h>"] = actions.select_default,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-l>"] = actions.close,
							["<M-j>"] = actions.preview_scrolling_down,
							["<M-k>"] = actions.preview_scrolling_up,
							["<M-h>"] = actions.preview_scrolling_left,
							["<M-l>"] = actions.preview_scrolling_right,
							-- Colemak mappings
							["<C-n>"] = actions.select_default,
							["<C-e>"] = actions.move_selection_next,
							["<C-i>"] = actions.move_selection_previous,
							["<C-o>"] = actions.close,
							["<M-e>"] = actions.preview_scrolling_down,
							["<M-i>"] = actions.preview_scrolling_up,
							["<M-n>"] = actions.preview_scrolling_left,
							["<M-o>"] = actions.preview_scrolling_right,
							-- TODO: actions.select_{horizontal, vertical, tab}
						},
					},
					initial_mode = "insert",
				},
				pickers = {
					diagnostics = {
						disable_coordinates = true,
					},
					find_files = {
						hidden = true,
						file_ignore_patterns = { "^%.git" },
					},
				},
			})
			require("telescope").load_extension("fzf")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>t", builtin.resume, {})
			vim.keymap.set("n", "<leader>f", builtin.find_files, {})
			vim.keymap.set("n", "<leader>F", builtin.git_files, {})
			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set("n", "<leader>G", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>Z", builtin.buffers, {})
			vim.keymap.set("n", "<leader>d", function()
				builtin.diagnostics({
					bufnr = 0,
					severity_bound = 0,
				})
			end, {})
			vim.keymap.set("n", "<leader>D", builtin.diagnostics, {})
			vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, {})
			vim.keymap.set("n", "<leader>gC", builtin.git_commits, {})
			vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
			vim.keymap.set("n", "<leader>hk", builtin.keymaps, {})
			vim.keymap.set("n", "gO", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "gS", builtin.lsp_workspace_symbols, {})
			vim.keymap.set("n", "grr", builtin.lsp_references, {})
			vim.keymap.set("n", "gri", builtin.lsp_definitions, {})
			vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "gra", desc = "Code Actions" },
		},
		config = function()
			require("actions-preview").setup({
				diff = {
					ctxlen = 2,
					algorithm = "histogram",
				},
				backend = { "telescope" },
				telescope = {
					sorting_strategy = "ascending",
					layout_strategy = "cursor",
					layout_config = {
						preview_width = 0.6,
						width = 0.8,
						height = 16,
					},
				},
			})
			vim.keymap.set({ "n", "v" }, "gra", require("actions-preview").code_actions)
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		event = "BufEnter",
		opts = {
			signs = true,
			keywords = {
				ERROR = {
					icon = "🐈",
					color = "error",
					alt = { "ISSUE", "FUCK" },
				},
				TODO = {
					icon = "📝",
					color = "info",
					alt = { "NOTE" },
				},
				FIX = {
					icon = "👀",
					color = "warning",
					alt = { "WARN", "FIXME" },
				},
			},
			color = {
				error = { "DiagnosticError" },
				warning = { "DiagnosticWarning" },
				info = { "DiagnosticInfo" },
			},
			highlight = {
				keyword = "fg",
			},
		},
	},
}

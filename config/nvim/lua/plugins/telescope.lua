return {
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		keys = {
			{ "<leader>f",  desc = "Find All Files" },
			{ "<leader>F",  desc = "Find Git Files" },
			{ "<leader>/",  desc = "FZF In File" },
			{ "<leader>G",  desc = "Grep Text" },
			{ "<leader>Z",  desc = "Buffer Telescope Menu" },
			{ "<leader>s",  desc = "Local Symbols" },
			{ "<leader>S",  desc = "Global Symbols" },
			{ "<leader>d",  desc = "Local Diagnostics" },
			{ "<leader>D",  desc = "Global Diagnostics" },
			{ "<leader>gc", desc = "List Commits" },
			{ "<leader>gC", desc = "List All Commits" },
			{ "<leader>gs", desc = "Git Status" },
			{ "<leader>hk", desc = "Search keymaps" },
			{ "gr",         desc = "References" },
			{ "gd",         desc = "Definitions" },
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = "👉",
					layout_config = {
						width = 0.90,
						height = 0.90,
						prompt_position = "bottom", --TODO: Make prompt and results anchor to the top side
						preview_width = 0.5,
					},
					layout_strategy = "horizontal",
					wrap_results = true,
					borderchars = require("globals").border_chars_alternate,
					default_mappings = {
						n = {
							["<Esc>"] = actions.close,
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
						},
						i = {
							["<Esc>"] = false,
							["<C-c>"] = false,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-h>"] = actions.select_default,
							["<C-l>"] = actions.close,
							["<M-j>"] = actions.preview_scrolling_down,
							["<M-k>"] = actions.preview_scrolling_up,
							["<M-h>"] = actions.preview_scrolling_left,
							["<M-l>"] = actions.preview_scrolling_right,
							-- TODO: actions.select_{horizontal, vertical, tab}
						},
					},
					initial_mode = "insert",
				},
				pickers = {
					diagnostics = {
						disable_coordinates = true,
					},
				},
			})
			require("telescope").load_extension("fzf")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>f", builtin.find_files, {})
			vim.keymap.set("n", "<leader>F", builtin.git_files, {})
			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set("n", "<leader>G", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>Z", builtin.buffers, {})
			vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, {})
			vim.keymap.set("n", "<leader>S", builtin.lsp_workspace_symbols, {})
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
			vim.keymap.set("n", "gr", builtin.lsp_references, {})
			vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
			vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>a", desc = "Code Actions" },
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
			vim.keymap.set({ "n", "v" }, "<leader>a", require("actions-preview").code_actions)
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

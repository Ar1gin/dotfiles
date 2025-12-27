return {
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
}

return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	keys = {
		{ "<leader>lt", "<cmd>:TSToggle<cr>", desc = "Toggle Treesitter for current buffer" },
	},
	config = function()
		require("nvim-treesitter").install({
			"lua",
		})
		local ts_or_fallback = function(fallback)
			if vim.treesitter.get_parser(nil, nil, { error = false }) then
				if vim.b.ts_highlight then
					vim.treesitter.stop()
				else
					vim.treesitter.start()
				end

				if vim.b.syntax then
					vim.b.syntax = false
					vim.cmd("syntax off")
				end
				return true
			else
				if vim.b.syntax then
					vim.b.syntax = false
					vim.cmd("syntax off")
				else
					if fallback then
						vim.b.syntax = true
						vim.cmd("syntax on")
						vim.cmd("syntax match Number /\\d\\+/")
						vim.cmd("syntax match @punctuation.bracket /(\\|)/")
						vim.cmd("syntax match @punctuation.delimiter /\\./")
						vim.cmd("syntax match Boolean /True\\|true\\|False\\|false/")
						vim.cmd("syntax match Operator /=\\|+\\|#/")
						vim.cmd("syntax match String /\"\\|`\\|'/")
					end
				end
				return false
			end
		end

		vim.api.nvim_create_user_command("TSToggle", function(_)
			if not ts_or_fallback(true) then
				vim.api.nvim_echo({ { "Could not start TS server for current buffer", nil } }, true, {})
			end
		end, { desc = "Toggle Treesitter for current buffer" })
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				ts_or_fallback(false)
			end,
		})
	end,
	build = ":TSUpdate",
}

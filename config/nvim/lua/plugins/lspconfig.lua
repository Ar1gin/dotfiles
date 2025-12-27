return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_enable = false,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		lazy = false,
		keys = {
			{ "<leader>s",  "<cmd>Format<cr>",                          desc = "Format" },
			{ "<leader>S",  "<cmd>Format<cr><cmd>write<cr>",            desc = "Format & Write" },
			{ "<leader>lh", desc = "Toggle inlay hints for buffer" },
			{ "<leader>lH", desc = "Toggle inlay hints for all buffers" },
		},
		config = function()
			vim.api.nvim_create_user_command("Format", function(_) vim.lsp.buf.format() end,
				{ desc = "Format current buffer with LSP" })
			vim.keymap.set("n", "<leader>lh", function()
				local bufnr = vim.api.nvim_get_current_buf()
				vim.lsp.inlay_hint.enable(
					not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
					{ bufnr = bufnr }
				)
			end)
			vim.keymap.set("n", "<leader>lH",
				function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" }
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					},
				},
			})
			local lsp_servers = {
				"rust_analyzer",
				"clangd",
				"pylsp",
				"marksman",
				"taplo",
				"zls",
				"ts_ls",
				"gopls",
				"texlab",
				"qmlls",
				"lua_ls",
			}
			for _, lsp_server in ipairs(lsp_servers) do
				vim.lsp.enable(lsp_server, true)
			end
		end,
	},
}

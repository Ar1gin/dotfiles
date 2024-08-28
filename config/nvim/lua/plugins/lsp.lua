return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "rust" },
				highlight = { enable = true },
			})
		end,
		build = ":TSUpdate"
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
			{ "<leader>w", "<cmd>Format<cr>",               desc = "Format" },
			{ "<leader>W", "<cmd>Format<cr><cmd>write<cr>", desc = "Format & Write" }
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" }
			})
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- TODO: Gotta make this into an quick toggle

			-- vim.api.nvim_create_autocmd("LspAttach", {
			-- 	callback = function(args)
			-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
			--
			-- 		if client and client.server_capabilities.inlayHintProvider then
			-- 			vim.lsp.inlay_hint.enable(args.buf, true)
			-- 		end
			-- 	end
			-- })
			require("lspconfig").lua_ls.setup({
				on_init = function(client)
					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					})
				end,
				settings = { Lua = {} },
				capabilities = capabilities,
			})
			local lsp_servers = {
				"rust_analyzer",
				"clangd",
				"pylsp",
				"marksman",
				"taplo",
				"zls",
			}
			local lsp_config = require("lspconfig")
			for _, lsp_server in ipairs(lsp_servers) do
				lsp_config[lsp_server].setup({
					capabilities = capabilities,
				})
			end
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
					vim.api.nvim_buf_create_user_command(ev.buf, "Format", function(_)
						vim.lsp.buf.format()
					end, { desc = "Format current buffer with LSP" })
				end
			})
		end,
	},
	{

		"hrsh7th/nvim-cmp",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			-- IMPORTANT OPTION!
			vim.opt.pumheight = 7
			local cmp = require("cmp")
			local kinds = {
				Field = { " Field", "Identifier" },
				Class = { " Type", "Type" },
				Variable = { "󰽏 Variable", "Statement" },
				Method = { " Method", "Function" },
				Function = { "󰊕 Function", "Function" },
				Enum = { "󰷐 Enum", "Boolean" },
				Keyword = { " Keyword", "Keyword" },
				Constant = { "󰽏 Const", "Boolean" },
				Struct = { " Struct", "Type" },
				Interface = { "󱇯 Trait", "Type" },
				Module = { " Module", "Statement" },
				EnumMember = { "󰷐 Value", "Boolean" },
				File = { " File", "Statement" },
				Snippet = { " Snippet", "Keyword" },
				Value = { "󰎠 Value", "Number" },
				Property = { "󰜢 Field", "Identifier" },
				Reference = { " Reference", "Statement" },
				Text = { " Text", "String" },
				-- Left as an exercise to the reader
				-- Constructor = "",
				-- Unit = "",
				-- Color = "󰏘",
				-- Folder = "󰉋",
				-- Event = "",
				-- Operator = "󰆕",
				-- TypeParameter = "󰅲",
			}
			for kind, link in pairs(kinds) do
				vim.api.nvim_set_hl(0, "CmpItemKind" .. kind, { link = link[2] })
			end
			cmp.setup({
				formatting = {
					format = function(_, vim_item)
						local custom = kinds[vim_item.kind]
						if custom then
							vim_item.kind = string.format("%-12s", custom[1])
						else
							vim_item.kind = string.format("%-12s", vim_item.kind)
						end
						if vim_item.abbr then
							local content = vim_item.abbr
							local fixed_width = 32
							if #content > fixed_width then
								local ellipsis = ""
								vim_item.abbr = " " .. vim.fn.strcharpart(content, 0, fixed_width - 1) .. ellipsis
							else
								vim_item.abbr = " " .. string.format("%-32s", content)
							end
						end
						vim_item.menu = ""
						return vim_item
					end,
					fields = {
						"abbr",
						"kind",
					}
				},
				sources = cmp.config.sources({
					-- FIXME: Suggestion sorting is bogus;
					-- All the useful suggestions are at the bottom
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer" },
				}),
				mapping = cmp.mapping.preset.insert({
					["<C-h>"] = cmp.mapping.confirm(),
					["<C-l>"] = cmp.mapping.abort(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<A-j>"] = cmp.mapping.scroll_docs(6),
					["<A-k>"] = cmp.mapping.scroll_docs(-6),
				}),
				window = {
					completion = {
						side_padding = 0,
					},
					documentation = {
						max_width = 64,
						max_height = 16,
					},
				}
			})
		end
	},
}

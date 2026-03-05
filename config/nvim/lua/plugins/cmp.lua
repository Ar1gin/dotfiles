return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
	},
	event = "VeryLazy",
	config = function()
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
			Folder = { "󰉋 Folder", "Statement" },
			-- Left as an exercise to the reader
			-- Constructor = "",
			-- Unit = "",
			-- Color = "󰏘",
			-- Event = "",
			-- Operator = "󰆕",
			-- TypeParameter = "󰅲",
		}
		for kind, link in pairs(kinds) do
			vim.api.nvim_set_hl(0, "CmpItemKind" .. kind, { link = link[2] })
		end
		local confirm_or_complete = function(fallback)
			if cmp.visible() then
				cmp.mapping.confirm({ select = true })(fallback)
			else
				cmp.mapping.complete()(fallback)
			end
		end
		local next_or_complete = function(fallback)
			if cmp.visible() then
				cmp.mapping.select_next_item()(fallback)
			else
				cmp.mapping.complete()(fallback)
				cmp.mapping.select_next_item()(fallback)
			end
		end
		local previous_or_complete = function(fallback)
			if cmp.visible() then
				cmp.mapping.select_prev_item()(fallback)
			else
				cmp.mapping.complete()(fallback)
				cmp.mapping.select_next_item()(fallback)
			end
		end
		local formatting = {
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
			},
		}
		local mapping = ({
			-- QWERTY mappings
			["<C-h>"] = { i = confirm_or_complete, c = confirm_or_complete },
			["<C-j>"] = { i = next_or_complete, c = next_or_complete },
			["<C-k>"] = { i = previous_or_complete, c = previous_or_complete },
			["<C-l>"] = { i = cmp.mapping.abort(), c = cmp.mapping.abort() },
			["<A-j>"] = { i = cmp.mapping.scroll_docs(6), c = cmp.mapping.scroll_docs(6) },
			["<A-k>"] = { i = cmp.mapping.scroll_docs(-6), c = cmp.mapping.scroll_docs(-6) },
			-- Colemak mappings
			["<C-n>"] = { i = confirm_or_complete, c = confirm_or_complete },
			["<C-e>"] = { i = next_or_complete, c = next_or_complete },
			["<C-i>"] = { i = previous_or_complete, c = previous_or_complete },
			["<C-o>"] = { i = cmp.mapping.abort(), c = cmp.mapping.abort() },
			["<A-e>"] = { i = cmp.mapping.scroll_docs(6), c = cmp.mapping.scroll_docs(6) },
			["<A-i>"] = { i = cmp.mapping.scroll_docs(-6), c = cmp.mapping.scroll_docs(-6) },
		})
		local window = {
			completion = {
				side_padding = 0,
			},
			documentation = {
				max_width = 64,
				max_height = 16,
			},
		}
		-- NOTE: Use default sorting, but remove 'locality' to improve performance on files with
		-- very long lines. More info: [https://github.com/hrsh7th/nvim-cmp/issues/1841]
		local sorting = {
			priority_weight = 2,
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				-- compare.scopes, -- Removed in the default settings
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				-- compare.locality, -- Removed due to above reason
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			}
		}
		cmp.setup({
			completion = {
				autocomplete = false,
			},
			formatting = formatting,
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				-- { name = "buffer" }, -- Unnecessary with ^F and ^P
				{ name = "render-markdown" },
				{ name = "emoji" },
				{ name = "path" },
			}),
			sorting = sorting,
			mapping = mapping,
			window = window,
		})
		cmp.setup.cmdline("/", {
			sources = cmp.config.sources({
				{ name = "buffer" },
			}),
			sorting = sorting,
			mapping = mapping,
		})
		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({
				{ name = "path" },
				{
					name = 'cmdline',
					option = { ignore_cmds = { 'Man', '!' } }
				},
			}),
			sorting = sorting,
			mapping = mapping,
		})
	end,
}

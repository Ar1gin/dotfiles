return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	opts = {
		checkbox = {
			position = "inline",
			unchecked = {
				icon = "󰳟 [ ]",
			},
			checked = {
				icon = "󰳟 []",
				scope_highlight = "RenderMarkdownCheckedScope",
			},
			custom = {
				in_progress = { raw = "[/]", rendered = "󰳟 []", highlight = "RenderMarkdownWip", scope_highlight = nil },
				todo        = { raw = "[-]", rendered = "󰳟 []", highlight = "RenderMarkdownCanceled", scope_highlight = "RenderMarkdownCheckedScope" },
				important   = { raw = "[!]", rendered = "󰳟 []", highlight = "RenderMarkdownImportant", scope_highlight = nil },
				unknown     = { raw = "[?]", rendered = "󰳟 []", highlight = "RenderMarkdownUnknown", scope_highlight = nil },
				idea        = { raw = "[@]", rendered = "󰳟 []", highlight = "RenderMarkdownIdea", scope_highlight = nil },
				starred     = { raw = "[*]", rendered = "󰳟 []", highlight = "RenderMarkdownStar", scope_highlight = nil },
				positive    = { raw = "[+]", rendered = "󰳟 [+]", highlight = "RenderMarkdownPositive", scope_highlight = nil },
				negative    = { raw = "[=]", rendered = "󰳟 [-]", highlight = "RenderMarkdownNegative", scope_highlight = nil },
			},
		},
		code = {
			above = "█",
			below = "█",
			inline_pad = 1,
		},
	},
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		opts = {},
	},
}

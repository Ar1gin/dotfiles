local wezterm = require("wezterm")
local config = {}

local font_family = "Hack Nerd Font Mono"
config.font = wezterm.font(font_family, {
	weight = "Regular",
	italic = false,
})
config.font_rules = {}
for _, intensity in ipairs({ "Normal", "Bold" }) do
	for _, italic in ipairs({ false, true }) do
		table.insert(config.font_rules, {
			intensity = intensity,
			italic = italic,
			font = config.font,
		})
	end
end
config.freetype_load_flags = "FORCE_AUTOHINT"
config.font_size = 14
config.max_fps = 75
config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.colors = {
	foreground = "#C5C8C6",
	background = "#000000",
	cursor_bg = "#C5C8C6",
	cursor_fg = "#000000",
	ansi = {
		"#282A2E",
		"#A54242",
		"#8C9440",
		"#DE935F",
		"#5F819D",
		"#85678F",
		"#5E8D87",
		"#707880",
	},
	brights = {
		"#373B41",
		"#FF5555",
		"#B5BD68",
		"#F0C674",
		"#81A2BE",
		"#B294BB",
		"#8ABEB7",
		"#C5C8C6",
	},
}
config.background = {
	{
		source = {
			Gradient = {
				orientation = { Linear = { angle = -20.0 } },
				colors = {
					-- Base colors:
					-- #1D1E27, #15151C
					"#1C1D27",
					"#442B37", -- replaces #1C1D27
					"#1C1D27",
					"#1C1D27",
					"#1A1A23",
					"#1A1A23",
					"#1A1A23",
					"#1A1A23",
					"#171820",
					"#171820",
					"#171820",
					"#171820",
					"#15151C",
					"#15151C",
					"#44312A", -- replaces #15151C
					"#15151C",
				},
				interpolation = "Linear",
				noise = 0,
				segment_size = 16,
				segment_smoothness = 0.025,
			},
		},
		width = "100%",
		height = "100%",
	},
	{
		-- My beloved cat Niko
		source = { File = wezterm.config_dir .. "/niko.png" },
		width = "228px",
		height = "241px",
		repeat_x = "NoRepeat",
		repeat_y = "NoRepeat",
		vertical_align = "Bottom",
		horizontal_align = "Right",
		vertical_offset = "-2cell",
	},
}

return config

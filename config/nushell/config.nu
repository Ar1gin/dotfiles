let base16_theme = {
	leading_trailing_space_bg: { attr: n }
	separator: black
	header: light_gray
	date: light_green
	filesize: light_purple
	row_index: light_purple
	bool: yellow
	int: light_purple
	duration: light_purple
	range: light_purple
	float: light_purple
	string: light_green
	nothing: light_black
	binary: light_purple
	hints: light_black

	shape_garbage: { bg: light_red }
	shape_bool: yellow
	shape_int: light_purple
	shape_float: light_purple
	shape_range: yellow
	shape_internalcall: light_blue
	shape_external: gray
	shape_externalarg: light_gray
	shape_literal: light_blue
	shape_operator: yellow
	shape_signature: yellow
	shape_string: light_green
	shape_string_interpolation: green
	shape_filepath: light_green
	shape_globpattern: light_red
	shape_variable: light_gray
	shape_flag: gray
	shape_custom: light_blue
	shape_or: light_blue
	share_and: light_blue

	empty: light_gray
	cell-path: light_gray
	record: light_blue
	list: light_blue
	block: light_blue
	search_result: light_red
	shape_binary: light_green
	shape_block: yellow
	shape_closure: yellow
	shape_datetime: light_purple
	shape_directory: light_red
	shape_external_resolved: light_blue
	shape_glob_interpolation: light_red
	shape_keyword: light_purple
	shape_list: gray
	shape_match_pattern: yellow
	# shape_matching_brackets: light_purple
	shape_nothing: purple
	shape_pipe: yellow
	shape_record: gray
	shape_redirection: yellow
	shape_table: gray
	shape_vardecl: light_gray
	shape_raw_string: light_green
}

$env.config = {
	show_banner: false
	ls: { use_ls_colors: false }
	table: { mode: heavy }
	error_style: fancy
	datetime_format: {
		normal: '%D %r'
	}
	explore: {
		command_bar_text: { fg: light_gray },
		selected_cell: { bg: blue },
	}
	completions: {
		algorithm: fuzzy
		use_ls_colors: false
	}
	filesize: { metric: false }
	cursor_shape: {
		emacs: line
		vi_insert: line
		vi_normal: block
	}
	color_config: $base16_theme
	use_ansi_coloring: true
	bracketed_paste: true
	edit_mode: vi
	highlight_resolved_externals: true
	display_errors: {
		exit_code: false
	}
}

$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = { || starship prompt $'--status=($env.LAST_EXIT_CODE)' }
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_MULTILINE_INDICATOR = ""

source zoxide.nu

alias ll = exa -l
alias nv = nvim
alias zl = zellij
alias zla = zellij attach
alias zll = zellij list-sessions
alias cat = bat
alias lg = lazygit

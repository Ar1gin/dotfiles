return {
	"echasnovski/mini.surround",
	keys = {
		{ "ss", desc = "Surround: Add",         mode = { "n", "v" } },
		{ "sd", desc = "Surround: Delete" },
		{ "sf", desc = "Surround: Find (right)" },
		{ "sF", desc = "Surround: Find (left)" },
		{ "sr", desc = "Surround: Replace" },
	},
	opts = {
		mappings = {
			add = "ss",
			delete = "sd",
			find = "sf",
			find_left = "sF",
			highlight = "",
			replace = "sr",
			update_n_lines = "sn",
		}
	},
}

local function copy(args)
	return args[1]
end

return {
	-- Pasta
	s("js", { t("<script src=\""), i(1), t("\"></script>"), i(0) }),
	s("css", { t("<link rel=\"stylesheet\" href=\""), i(1), t("\">"), i(0) }),
	-- Tags
	s("tt", { t("<"), i(1), t(">"), i(2), t("</"), f(copy, 1), t(">"), i(0) }),
	s("ttb", { t("<"), i(1), t({ ">", "\t" }), i(2), t({ "", "</" }), f(copy, 1), t(">"), i(0) }),
}

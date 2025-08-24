return {
	-- Lazy pasta
	s("opt", t("@setFloatMode(.optimized);")),
	s("pt", t("?*")),
	s("dis", t("_ = ")),
	s("disp", t("_ = &")),
	-- Builtin functions
	s("as", { t("@as("), i(1), t(", "), i(2), t(")"), i(0) }),
	s("vec", { t("@Vector("), i(1), t(", "), i(2), t(")"), i(0) }),
	s("tof", { t("@TypeOf("), i(1), t(")"), i(0) }),
	s("tin", { t("@typeInfo("), i(1), t(")"), i(0) }),
	s("splat", { t("@splat("), i(1), t(")"), i(0) }),
	s("sqrt", { t("@sqrt("), i(1), t(")"), i(0) }),
	s("panic", { t("@panic("), i(1), t(")"), i(0) }),
	-- Syntax pasta
	s({ trig = "pr", wordTrig = false }, { i(1), t(" => "), n(2, "|"), i(2), n(2, "| "), t("{"), i(3), t("},"), i(0) }),
	s({ trig = "prb", wordTrig = false }, { i(1), t(" => "), n(2, "|"), i(2), n(2, "| "), t({ "{", "\t" }), i(3), t({ "", "}," }), i(0) }),
	s("im", { t("const "), i(1), t(" = @import(\""), i(2), t("\");"), i(0), }),
}

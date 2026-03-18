local function copy(args)
	return args[1]
end

return {
	-- Lazy pasta
	s("opt", t("@setFloatMode(.optimized);")),
	s("pt", t("?*")),
	s("dis", t("_ = ")),
	s("disp", t("_ = &")),
	s("std", t("const std = @import(\"std\");")),
	-- Builtin functions
	s("as", { t("@as("), i(1, "type"), t(", "), i(2, "{}"), t(")"), i(0) }),
	s("vec", { t("@Vector("), i(1, "count"), t(", "), i(2, "type"), t(")"), i(0) }),
	s({ trig = "vec%d+", regTrig = true }, { t("@Vector("), f(function(_, snip) return string.sub(snip.trigger, 4) end), t(", "), i(1, "type"), t(")"), i(0) }),
	s({ trig = "vec%d+f", regTrig = true }, { t("@Vector("), f(function(_, snip) return string.sub(snip.trigger, 4, string.len(snip.trigger) - 1) end), t(", f32)") }),
	s("tof", { t("@TypeOf("), i(1), t(")"), i(0) }),
	s("tin", { t("@typeInfo("), i(1), t(")"), i(0) }),
	s("splat", { t("@splat("), i(1), t(")"), i(0) }),
	s("sqrt", { t("@sqrt("), i(1), t(")"), i(0) }),
	s("panic", { t("@panic("), i(1), t(")"), i(0) }),
	s("ffi", { t("@floatFromInt("), i(1), t(")"), i(0) }),
	s("iff", { t("@intFromFloat("), i(1), t(")"), i(0) }),
	s("this", { t("@This()"), i(0) }),
	-- Syntax pasta
	s({ trig = "pr", wordTrig = false }, { i(1), t(" => "), n(2, "|"), i(2), n(2, "| "), t("{"), i(3), t("},"), i(0) }),
	s({ trig = "prb", wordTrig = false }, { i(1), t(" => "), n(2, "|"), i(2), n(2, "| "), t({ "{", "\t" }), i(3), t({ "", "}," }), i(0) }),
	s("im", { t("const "), i(1), t(" = @import(\""), dl(2, l._1, 1), t("\");"), i(0), }),
	s("fn", { t("fn "), i(1), t("("), i(2), t(") "), i(3), t({ " {", "\t" }), i(4), t({ "", "}" }), i(0) }),
	s("str", { t({ "struct {", "\t" }), i(1), t({ "", "}" }), i(0) }),
	s("union", { t({ "union(" }), i(1), t({ ") {", "\t" }), i(2), t({ "", "}" }), i(0) }),
	s("pself", { t({ "self: *Self" }), i(0) }),
	s("cself", { t({ "self: Self" }), i(0) }),
	s("dself", { t({ "const " }), i(1, "Self"), t({ " = @This();" }), i(0) }),
	-- Misc
	s("const", t("var")),
	s("var", t("const")),
}

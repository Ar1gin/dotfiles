return {
	-- Blocks
	s({ trig = "ppb", wordTrig = false }, { t({ "(", "\t" }), i(1), t({ "", ")" }), i(0) }),
	s({ trig = "ssb", wordTrig = false }, { t({ "[", "\t" }), i(1), t({ "", "]" }), i(0) }),
	s({ trig = "bbb", wordTrig = false }, { t({ "{", "\t" }), i(1), t({ "", "}" }), i(0) }),
	s({ trig = "aab", wordTrig = false }, { t({ "<", "\t" }), i(1), t({ "", ">" }), i(0) }),
	-- Pairs
	s({ trig = "pp", wordTrig = false }, { t("("), i(1), t(")"), i(0) }),
	s({ trig = "ss", wordTrig = false }, { t("["), i(1), t("]"), i(0) }),
	s({ trig = "bb", wordTrig = false }, { t("{"), i(1), t("}"), i(0) }),
	s({ trig = "aa", wordTrig = false }, { t("<"), i(1), t(">"), i(0) }),
	s({ trig = "qq", wordTrig = false }, { t("'"), i(1), t("'"), i(0) }),
	s({ trig = "dd", wordTrig = false }, { t("\""), i(1), t("\""), i(0) }),
	s({ trig = "co", wordTrig = false }, { t("```"), i(1), t({ "", "```" }), i(0) }),
	-- Misc
	s({ trig = "ca", wordTrig = false }, { t("("), i(1), t(");"), i(0) }),
	-- Emoji
	s(
		{ trig = "emo%w+", regTrig = true },
		f(function(_, snip)
			local output = ""
			local emojis = {
				c = "🐈",
				k = "🔪",
				f = "🔥",
				m = "💪",
				s = "💀",
				t = "🎉",
				h = "❤️",
				b = "‼️",
				e = "👀",
				y = "😋",
				p = "😔",
			}
			for i = 4, string.len(snip.trigger), 1 do
				output = output .. (emojis[string.sub(snip.trigger, i, i)] or "")
			end
			return output
		end, {})
	),
}

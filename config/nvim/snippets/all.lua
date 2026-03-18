return {
	-- Blocks
	s({ trig = "()", wordTrig = false }, { t({ "(", "\t" }), i(1), t({ "", ")" }), i(0) }),
	s({ trig = "[]", wordTrig = false }, { t({ "[", "\t" }), i(1), t({ "", "]" }), i(0) }),
	s({ trig = "{}", wordTrig = false }, { t({ "{", "\t" }), i(1), t({ "", "}" }), i(0) }),
	s({ trig = "<>", wordTrig = false }, { t({ "<", "\t" }), i(1), t({ "", ">" }), i(0) }),
	s({ trig = "```", wordTrig = false }, { t({"```"}), i(1), t({ "", "```" }), i(0) }),
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

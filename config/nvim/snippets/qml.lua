return {
	s("fill", { t({ "anchors.fill: " }), c(1, { t(""), t("parent") }) }),
	s("lay", t({ "Layout.fillWidth: true", "Layout.fillHeight: true" })),
	s("qt", { t({ "import QtQuick", "", "" }), i(1), t({ " {", "\t" }), i(0), t({ "", "}" }) }),
	s("row", { t({ "RowLayout {", "\t" }), i(1), t({ "", "}" }), i(0) }),
	s("col", { t({ "ColumnLayout {", "\t" }), i(1), t({ "", "}" }), i(0) }),
}

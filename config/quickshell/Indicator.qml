import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

ColumnLayout {
    id: indicator
    required property string icon
    required property real value
    required property color color

    property bool lit: value >= 0.75
    property color usedColor: indicator.lit ? indicator.color : Colors.foregroundDim

    spacing: Constants.splitWidth
    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Icon {
            Layout.preferredWidth: height
            Layout.fillHeight: true
            path: indicator.icon
        }
        Counter {
            Layout.fillWidth: true
            Layout.fillHeight: true

            value: indicator.value * 100
            foreground: indicator.usedColor
        }
    }
    ProgBar {
        Layout.fillWidth: true
        Layout.preferredHeight: Constants.splitWidth
        fgColor: indicator.usedColor
        value: indicator.value
    }
}

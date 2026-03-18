import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

ViewRect {
    id: cell
    required property real value
    property color foreground: Colors.foreground
    default property alias children: layout.children

    RowLayout {
        id: layout
        anchors.fill: parent

        anchors.margins: Constants.splitWidthLarge
        spacing: Constants.splitWidth
        CircleBar {
            Layout.fillWidth: true
            Layout.fillHeight: true
            barWidth: Constants.splitWidth
            value: cell.value
            foreground: cell.foreground
            end: 0.95
            offset: -0.25 + 0.025
            clockwise: true
            Counter {
                value: cell.value * 100
                anchors.fill: parent
                anchors.leftMargin: parent.width * 0.125
                anchors.rightMargin: parent.width * 0.125
                font: Constants.largeFont
                foreground: cell.foreground
            }
        }
    }
}

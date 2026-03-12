import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

ViewRect {
    id: cell
    required property real value
    property color foreground: Colors.foreground

    default property alias data: layout.children
    RowLayout {
        anchors.fill: parent
        anchors.margins: parent.height * 0.125
        spacing: parent.height * 0.125
        CircleBarCounter {
            Layout.fillHeight: true
            // Layout.fillWidth: true
            Layout.preferredWidth: height
            Layout.minimumWidth: 0
            barWidth: Constants.splitWidth
            value: cell.value
            foreground: cell.foreground
        }
        ColumnLayout {
            id: layout
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0
        }
    }
}

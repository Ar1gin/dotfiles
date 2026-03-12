import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

Rectangle {
    id: box
    property int severity: 0
    property bool icon: true
    property string text: ""

    readonly property color background: Colors.alertBackground[severity]
    readonly property color foreground: Colors.alertForeground[severity]
    readonly property string iconName: Constants.alertIcon[severity]

    color: background
    radius: Constants.radius
    border {
        color: foreground
        width: Constants.splitWidth * 0.5
    }

    implicitWidth: row.implicitWidth + Constants.splitWidth * 2
    implicitHeight: row.implicitHeight + Constants.splitWidth * 2
    RowLayout {
        id: row
        anchors.fill: parent
        anchors.margins: Constants.splitWidth
        spacing: Constants.splitWidth
        IconImage {
            Layout.margins: 1
            Layout.fillHeight: true
            implicitWidth: height
            source: Quickshell.iconPath(box.iconName)
        }
        LabelText {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: box.text
            font.pointSize: height - Constants.splitWidth * 2
            color: box.foreground
        }
    }
}

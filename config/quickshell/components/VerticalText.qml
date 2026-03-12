import QtQuick
import QtQuick.Layouts

Item {
    id: vtext
    implicitWidth: label.implicitHeight
    implicitHeight: label.implicitWidth
    Layout.minimumHeight: 0
    Layout.minimumWidth: 0

    property Text label: LabelText {
        anchors.centerIn: parent
        rotation: -90
        height: vtext.width
        width: vtext.height
    }
    // Is that how I'm supposed to get this `label` to render?
    // Well it doesn't throw any warnings at least
    children: [label]
}

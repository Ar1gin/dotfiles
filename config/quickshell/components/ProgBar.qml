import QtQuick
import qs.config

Item {
    id: bar
    property color fgColor: Colors.foreground
    property color bgColor: Colors.dimmer
    property real value: 0.5
    property real radius: Constants.radius

    Rectangle {
        color: bar.bgColor
        anchors.fill: parent
        radius: bar.radius * 0.5
        anchors.margins: parent.height * 0.25
    }
    Rectangle {
        color: Colors.foreground
        opacity: 0.09375
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: parent.height * 0.25
        implicitWidth: parent.width * 0.03125
        radius: height * 0.5
    }
    Rectangle {
        color: bar.fgColor
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        implicitWidth: parent.width * value
        radius: bar.radius
    }
}

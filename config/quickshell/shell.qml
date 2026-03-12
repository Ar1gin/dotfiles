import Quickshell
import QtQuick
import qs.config

PanelWindow {
    id: panel
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: Constants.barHeight
    Bar {
        anchors.fill: parent
        anchors.bottomMargin: Constants.barBorderWidth
    }
    Rectangle {
        color: Colors.barBorder
        implicitHeight: Constants.barBorderWidth
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
    Ipc {
        barWindow: panel
    }
}

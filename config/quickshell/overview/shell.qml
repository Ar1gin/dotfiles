import Quickshell
import Quickshell.Wayland
import QtCore
import QtQuick
import QtQuick.Layouts
import "../config"
import "../default"

ShellRoot {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: window

            property var modelData
            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background

            Image {
                anchors.fill: parent
                source: "../assets/pattern_background.png"
                smooth: false
                fillMode: Image.Tile
            }
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: window.height * (0.5 - Constants.overviewZoom * 0.5) - window.height * Constants.overviewGap * 0.5 - height * 0.5
                implicitHeight: Constants.barHeight + Constants.borderHeight * 2
                color: Colors.border
                Rectangle {
                    anchors.fill: parent
                    anchors.topMargin: Constants.borderHeight
                    anchors.bottomMargin: Constants.borderHeight
                    color: Colors.background
                    Bar {
                        anchors.fill: parent
                        anchors.topMargin: Constants.borderHeight
                        anchors.bottomMargin: Constants.borderHeight
                        screen: modelData
                    }
                }
            }
        }
    }
}

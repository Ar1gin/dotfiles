import Quickshell
import Quickshell.Io
import QtQuick
import "../config"

ShellRoot {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            property var modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: Constants.barHeight + Constants.barShadowHeight + Constants.borderHeight
            aboveWindows: false
            exclusiveZone: Constants.barHeight + Constants.borderHeight
            exclusionMode: ExclusionMode.Normal
            color: Colors.none
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: Constants.barShadowHeight
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Colors.barShadow }
                    GradientStop { position: 1.0; color: Colors.none }
                }
            }
            Rectangle {
                anchors.fill: parent
                anchors.bottomMargin: Constants.barShadowHeight
                color: Colors.background
            }
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Constants.barShadowHeight
                implicitHeight: Constants.borderHeight
                color: Colors.border
            }
            Bar {
                screen: modelData
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: Constants.borderHeight
                height: Constants.barHeight - Constants.borderHeight * 2
            }
        }
    }
}

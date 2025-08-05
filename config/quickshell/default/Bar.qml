import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../config"

Scope {
    id: bar

    required property ShellScreen screen
    property real shadow: 4

    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: Constants.barHeight + bar.shadow
        aboveWindows: false
        exclusiveZone: Constants.barHeight
        color: Colors.none

        Rectangle {
            anchors.fill: parent
            anchors.bottomMargin: bar.shadow
            color: Colors.background
        }
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: bar.shadow
            gradient: Gradient {
                GradientStop { position: 0.0; color: Colors.barShadow }
                GradientStop { position: 1.0; color: Colors.none }
            }
        }
        RowLayout {
            anchors.fill: parent
            anchors.bottomMargin: Constants.borderHeight * 2 + bar.shadow
            anchors.topMargin: Constants.borderHeight
            spacing: Constants.borderHeight
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 1
                color: Colors.elementBackground
                Workspaces {
                    anchors.fill: parent
                    anchors.margins: Constants.borderHeight
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 1
                color: Colors.elementBackground
                Alerts {
                    anchors.fill: parent
                    anchors.margins: Constants.borderHeight
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 2
                color: Colors.elementBackground
                Clock {
                    anchors.fill: parent
                    anchors.margins: Constants.borderHeight
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 1
                color: Colors.elementBackground
                Music {
                    anchors.fill: parent
                    anchors.margins: Constants.borderHeight
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: 1
                color: Colors.elementBackground
                Indicators {
                    anchors.fill: parent
                    anchors.margins: Constants.borderHeight
                }
            }
        }

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: bar.shadow
            implicitHeight: Constants.borderHeight
            color: Colors.border
        }
    }
}

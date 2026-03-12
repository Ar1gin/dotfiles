import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config

Rectangle {
    color: Colors.background
    RowLayout {
        anchors.fill: parent
        spacing: Constants.splitWidth
        anchors.margins: Constants.splitWidth
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 64
            spacing: Constants.splitWidth
            Workspaces {
                Layout.preferredWidth: 192
                Layout.fillHeight: true
            }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            Indicators {
                Layout.fillHeight: true
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
        }
        Clock {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 48
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2
        }
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 64
            spacing: Constants.splitWidth
            Alerts {
                Layout.fillHeight: true
                implicitWidth: 512
            }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}

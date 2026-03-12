import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.config

// TODO:
// Battery health
// Disk status
// Audio control
// Brightness control
// Power mode management
// Networks
// Login management
// Notifications
// System tray
// Media player

ColumnLayout {
    spacing: Constants.splitWidth
    anchors.margins: Constants.splitWidth
    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 1
        spacing: Constants.splitWidth
        Repeater {
            model: [
                "applications-system-symbolic",
                "network-connect-symbolic",
                "library-music-symbolic",
                "audio-symbolic",
                "notifications",
                "arrow-down",
                "system-shutdown",
            ]
            Button {
                Layout.fillWidth: true
                Layout.fillHeight: true
                required property var modelData
                required property var index
                icon.source: Quickshell.iconPath(modelData)

                Component.onCompleted: {
                    if (index == 0) {
                        forceActiveFocus();
                    }
                }
            }
        }
    }
    OverviewMain {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 8
    }
}

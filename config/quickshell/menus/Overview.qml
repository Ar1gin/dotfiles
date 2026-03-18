import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.config
import qs.components

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

WindowRect {
    id: wrect
    ColumnLayout {
        anchors.fill: parent
        Keys.onPressed: event => {
            if (event.key >= Qt.Key_1 && event.key <= Qt.Key_9) {
                if (event.key - Qt.Key_1 >= stack.children.length)
                    return;
                stack.currentIndex = event.key - Qt.Key_1;
            }
        }
        Keys.forwardTo: [stack.children[stack.currentIndex]]
        focus: true

        spacing: Constants.splitWidth
        anchors.margins: Constants.splitWidth + wrect.border.width
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 1
            spacing: Constants.splitWidth
            Repeater {
                model: [
                    "applications-system-symbolic",
                    "notifications",
                    "library-music-symbolic",
                    "audio-symbolic",
                    "network-connect-symbolic",
                    "arrow-down",
                    "system-shutdown",
                ]
                ViewRect {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    required property var modelData
                    required property var index
                    Icon {
                        anchors.fill: parent
                        anchors.margins: Constants.splitWidthLarge
                        path: modelData
                    }
                    border.color: stack.currentIndex == index ? Colors.foreground : Colors.foregroundDim
                }
            }
        }
        StackLayout {
            id: stack
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 8
            currentIndex: 0

            OverviewMain {}
            OverviewNotifications {}
            OverviewMedia {}
            ViewRect {}
            ViewRect {}
            ViewRect {}
            ViewRect {}
        }
    }
}

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config
import qs.menus

Scope {
    id: ipc
    required property var barWindow

    PopupWrapper {
        id: overviewWindow
        implicitWidth: 1024
        implicitHeight: 768
        color: Colors.background
        Overview {
            anchors.fill: parent
        }
        visible: true
    }
    IpcHandler {
        target: "bar"

        function toggleOverview() {
            overviewWindow.active = !overviewWindow.active;
        }
    }
}

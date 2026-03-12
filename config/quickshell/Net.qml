pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

Singleton {
    id: net

    property bool online: false

    Process {
        id: netCheckProc
        command: ["nm-online", "-t", "0"]
        running: true
        Component.onCompleted: {
            netCheckProc.exited.connect(updateState)
        }
        function updateState(exitCode, _) {
            net.online = exitCode == 0;
        }
    }
    Timer {
        interval: online ? (Constants.updateDelay * 30) : Constants.updateDelay
        running: true
        repeat: true
        onTriggered: {
            netCheckProc.running = true;
        }
    }
}

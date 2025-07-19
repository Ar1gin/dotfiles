pragma Singleton
import Quickshell.Io
import QtQuick

Item {
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
        interval: Constants.alertUpdateDelay
        running: true
        repeat: true
        onTriggered: {
            netCheckProc.running = true;
        }
    }
}

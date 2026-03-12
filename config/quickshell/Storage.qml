pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

Singleton {
    id: storage
    property var drives: []

    Process {
        id: driveCheckProc
        property var new_drives: []
        property int skip: 1

        command: ["df", "-x", "tmpfs", "-x", "devtmpfs", "-x", "efivarfs", "--output=used,size,target"]
        running: true
        stdout: SplitParser {
            onRead: function (data) {
                if (driveCheckProc.skip > 0) {
                    driveCheckProc.skip -= 1;
                    return;
                }

                const line = data.trim().split(/ +/);
                const new_drive = [];

                const used = parseInt(line[0]);
                const size = parseInt(line[1]);
                const target = line[2];

                driveCheckProc.new_drives.push([target, used, size]);
            }
        }
        onExited: function () {
            storage.drives = driveCheckProc.new_drives;
            driveCheckProc.new_drives = [];
        }
    }
    Timer {
        running: true
        repeat: true
        interval: Constants.updateDelay * 10
        onTriggered: {
            driveCheckProc.skip = 1;
            driveCheckProc.running = true;
        }
    }
}

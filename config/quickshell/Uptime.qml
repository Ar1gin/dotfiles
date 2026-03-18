pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

Singleton {
    id: uptime

    property real loadavg_1m: 0
    property real loadavg_5m: 0
    property real loadavg_15m: 0
    property real cpucount: 0

    property real uptime: 0
    property int users: 0

    Process {
        id: uptimeCheckProc

        command: ["uptime", "-r"]
        running: true
        stdout: SplitParser {
            onRead: function (data) {
                const line = data.split(" ");
                uptime.uptime = parseFloat(line[1]);
                uptime.users = parseInt(line[2]);
                uptime.loadavg_1m = parseFloat(line[3]);
                uptime.loadavg_5m = parseFloat(line[4]);
                uptime.loadavg_15m = parseFloat(line[5]);
            }
        }
    }
    Process {
        id: cpuCheckProc

        command: ["find", "/dev/cpu", "-mindepth", "1", "-maxdepth", "1"]
        running: true
        stdout: SplitParser {
            onRead: function (_) {
                uptime.cpucount += 1;
            }
        }
    }
    Timer {
        running: true
        repeat: true
        interval: Constants.updateDelay
        onTriggered: {
            uptimeCheckProc.running = true;
        }
    }
}

pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Item {
    id: ram

    property int memTotal: 1
    property int memAvailable: 1
    property int swapTotal: 0
    property int swapUsed: 0
    property real memUsage: 1.0 - ram.memAvailable / ram.memTotal
    property real swapUsage: ram.swapTotal > 0 ? ram.swapUsed / ram.swapTotal : 0
    property bool hasSwap: ram.swapTotal > 0

    Process {
        id: memTotalCheckProc

        command: ["sed", "-n", "s/MemTotal: *\\([[:digit:]]*\\) kB/\\1/p", "/proc/meminfo"]
        running: true
        stdout: SplitParser {
            onRead: data => ram.memTotal = parseInt(data)
        }
    }
    Process {
        id: memAvailableCheckProc

        command: ["sed", "-n", "s/MemAvailable: *\\([[:digit:]]*\\) kB/\\1/p", "/proc/meminfo"]
        running: true
        stdout: SplitParser {
            onRead: data => ram.memAvailable = parseInt(data)
        }
    }
    Process {
        id: swapCheckProc

        // TODO: Detect multiple swapfiles
        command: ["sed", "-n", "1d;s/^[^ \t]* *[^ \t]*\t*\\([[:digit:]]*\\)\t*\\([[:digit:]]*\\).*/\\1 \\2/p;q", "/proc/swaps"]
        running: true
        stdout: SplitParser {
            onRead: function(data) {
                const swap = data.split(" ");
                ram.swapTotal = parseInt(swap[0]);
                ram.swapUsed = parseInt(swap[1]);
            }
        }
    }
    Timer {
        running: true
        repeat: true
        interval: Constants.indicatorUpdateDelay
        onTriggered: {
            memAvailableCheckProc.running = true;
            swapCheckProc.running = true;
        }
    }
}

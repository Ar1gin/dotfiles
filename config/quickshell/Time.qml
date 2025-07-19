pragma Singleton
import Quickshell.Io
import QtQuick

Item {
    id: time

    property string timeDisplay: ""
    property int secondsSinceMidnight: 12 * 3600

    Process {
        id: dateTimeProc
        command: ["date", Constants.dateFormat]
        running: true
        stdout: SplitParser {
            onRead: data => time.timeDisplay = data
        }
    }
    Process {
        id: dateSecondProc
        command: ["date", "+%H %M %S"]
        running: true
        stdout: SplitParser {
            onRead: function (data) {
                const hms = data.split(" ");
                time.secondsSinceMidnight = parseInt(hms[0]) * 3600 + parseInt(hms[1] * 60) + parseInt(hms[2]);
            }
        }
    }
    Timer {
        interval: Constants.dateRefreshDelay
        running: true
        repeat: true
        onTriggered: function () {
            dateTimeProc.running = true;
            dateSecondProc.running = true;
        }
    }
}

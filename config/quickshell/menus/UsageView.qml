import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components
import qs

ViewRect {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Constants.splitWidthLarge

        RowLayout {
            Layout.fillWidth: true

            spacing: Constants.splitWidthLarge
            Item {
                Layout.fillWidth: true
            }
            Counter {
                value: Uptime.loadavg_1m * 100.0
                preZeroes: 4
                postZeroes: 1
                postfix: "%"
                foreground: Colors.cpuAccent
            }
            Counter {
                value: Uptime.loadavg_5m * 100.0
                preZeroes: 4
                postZeroes: 1
                postfix: "%"
            }
            Counter {
                value: Uptime.loadavg_15m * 100.0
                preZeroes: 4
                postZeroes: 1
                postfix: "%"
                foreground: Colors.foregroundDim
            }
            Item {
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Layout.fillHeight: true
            spacing: Constants.splitWidth
            Item {
                Layout.fillWidth: true
            }
            Repeater {
                model: Uptime.cpucount
                Rectangle {
                    required property int index
                    implicitWidth: Constants.splitWidthLarge
                    implicitHeight: Constants.splitWidthLarge
                    color: Constants.lerpColor(Colors.dimmer, Colors.cpuAccent, Math.max(Math.min(Uptime.loadavg_1m - index, 1), 0))
                    radius: Constants.radius
                }
            }
            Item {
                Layout.fillWidth: true
            }
        }
        Image {
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: "../resources/kitty.png"
            fillMode: Image.PreserveAspectFit
        }
        LabelText {
            Layout.fillWidth: true
            text: `Uptime: ${Constants.formatDuration(Uptime.uptime)}`
            color: Colors.foregroundDim
        }
    }
}

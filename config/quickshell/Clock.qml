import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

ColumnLayout {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    spacing: Constants.splitWidth
    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: Constants.splitWidth
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            RowLayout {
                anchors.fill: parent
                spacing: Constants.splitWidth
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    // TODO: Show season symbolic
                }
                LabelText {
                    Layout.fillHeight: true
                    text: Qt.formatDate(clock.date, "dddd dd")
                    horizontalAlignment: Text.AlignRight
                }
            }
        }
        LabelText {
            Layout.fillHeight: true
            text: "/"
            color: Colors.foregroundDim
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            RowLayout {
                anchors.fill: parent
                spacing: Constants.splitWidth
                LabelText {
                    Layout.fillHeight: true
                    text: Qt.formatDateTime(clock.date, "hh:mm AP")
                    horizontalAlignment: Text.AlignLeft
                }
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    // TODO: Show daytime symbolic
                }
            }
        }
    }
    ProgBar {
        Layout.fillWidth: true
        Layout.preferredHeight: Constants.splitWidth

        value: (clock.seconds + 60 * (clock.minutes + 60 * clock.hours)) / (24 * 60 * 60)
    }
}

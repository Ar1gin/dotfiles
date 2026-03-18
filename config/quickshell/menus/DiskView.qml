import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components
import qs

ViewRect {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Constants.splitWidthLarge
        spacing: Constants.splitWidth
        Repeater {
            model: Storage.drives
            ColumnLayout {
                id: row
                required property var modelData
                Layout.fillWidth: true
                RowLayout {
                    spacing: 0
                    LabelText {
                        text: ":"
                        color: Colors.foregroundDim
                    }
                    LabelText {
                        text: row.modelData[0]
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    ByteSpaceCounter {
                        used: row.modelData[1] * 1024.0
                        total: row.modelData[2] * 1024.0
                        foreground: Colors.driveAccent
                    }
                }
                ProgBar {
                    Layout.fillWidth: true
                    implicitHeight: Constants.splitWidth * 2
                    radius: Constants.radius * 2
                    fgColor: Colors.driveAccent
                    value: row.modelData[1] / row.modelData[2]
                }
            }
        }
    }
}

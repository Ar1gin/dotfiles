import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components
import qs

ViewRect {
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: parent.height * 0.125
        spacing: Constants.splitWidth
        LabelText {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "RAM"
            color: Colors.foregroundDim
        }
        ByteSpaceCounter {
            Layout.fillWidth: true
            Layout.fillHeight: true
            used: (Ram.memTotal - Ram.memAvailable) * 1024.0
            total: Ram.memTotal * 1024.0
            foreground: Colors.memAccent
        }
        ProgBar {
            Layout.fillWidth: true
            implicitHeight: Constants.splitWidth * 2
            value: Ram.memUsage
            fgColor: Colors.memAccent
            radius: Constants.splitWidth * 2
        }
        ProgBar {
            Layout.fillWidth: true
            implicitHeight: Constants.splitWidth * 2
            value: Ram.swapUsage
            fgColor: Colors.memAccent
            radius: Constants.splitWidth * 2
        }
        ByteSpaceCounter {
            Layout.fillWidth: true
            Layout.fillHeight: true
            used: Ram.swapUsed * 1024.0
            total: Ram.swapTotal * 1024.0
            foreground: Colors.memAccent
        }
        LabelText {
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "SWAP"
            color: Colors.foregroundDim
        }
    }
}

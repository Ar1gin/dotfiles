import QtQuick
import QtQuick.Layouts

Item {
    id: root

    Repeater {
        id: rep
        model: [
            [Ram.memUsage >= Constants.memAlertPercentage, "MEMORY ALERT: " + parseInt(Ram.memUsage * 100) + "%"],
            [Ram.swapUsage >= Constants.memAlertPercentage, "SWAP ALERT: " + parseInt(Ram.swapUsage * 100) + "%"],
            [!Net.online, "OFFLINE"],
        ]
        PatternRect {
            required property var modelData
            parent: visible ? alerts : root
            Layout.fillWidth: true
            Layout.fillHeight: true
            mainColor: Colors.indicatorAlertBorder
            secondaryColor: Colors.indicatorAlert
            borderWidth: Constants.borderHeight
            patternSource: "pattern_alert.png"
            visible: modelData[0]
            PText {
                anchors.fill: parent
                font: Constants.mainFont
                color: Colors.indicatorAlertText
                text: modelData[1]
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: Constants.borderHeight

        StackLayout {
            id: alerts
            visible: children.length > 0
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        Rectangle {
            Layout.fillHeight: true
            implicitWidth: height * 2
            visible: alerts.children.length > 1
            color: Colors.indicatorAlert
            border.width: Constants.borderHeight
            border.color: Colors.indicatorAlertBorder
            PText {
                anchors.fill: parent
                font: Constants.mainFont
                color: Colors.indicatorAlertText
                text: "+" + (alerts.children.length - 1)
            }
        }
        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: alerts.children.length == 0
            color: Colors.workspaceButtonInactive
            border.width: Constants.borderHeight
            border.color: Colors.workspaceButtonInactiveBorder
            PText {
                anchors.fill: parent
                font: Constants.smallFont
                color: Colors.foregroundDim
                text: "~ No alerts ~"
            }
        }
    }
}

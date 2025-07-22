import QtCore
import Quickshell
import QtQuick
import QtQuick.Layouts
import "../config"

PanelWindow {
    anchors.top: true
    anchors.bottom: true
    margins.top: 100
    margins.bottom: 100

    implicitWidth: height * 1.5

    focusable: true
    exclusionMode: ExclusionMode.Normal

    Shortcut {
        sequences: ["Escape"]
        onActivated: Qt.quit()
    }

    Rectangle {
        anchors.fill: parent
        border.width: Constants.borderHeight
        border.color: Colors.border
        color: Colors.elementBackground
        RowLayout {
            anchors.fill: parent
            anchors.margins: Constants.borderHeight * 2
            spacing: Constants.borderHeight
            Panel {
                id: leftPanel
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            Panel {
                id: rightPanel
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            Settings {
                category: "panel"
                property alias leftIndex: leftPanel.index
                property alias rightIndex: rightPanel.index
            }
        }
    }
}

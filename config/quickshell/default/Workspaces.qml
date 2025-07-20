import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../components"
import "../config"

RowLayout {
    spacing: Constants.borderHeight
    Rectangle {
        Layout.fillWidth: true
        color: Colors.background
        implicitHeight: parent.height * 0.2
    }
    Repeater {
        model: Hyprland.workspaces
        Rectangle {
            required property var modelData
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: height
            Layout.maximumWidth: height * 2
            color: Hyprland.focusedWorkspace == modelData ? Colors.workspaceButtonMain : Colors.workspaceButtonInactive
            border.width: Constants.borderHeight
            border.color: Hyprland.focusedWorkspace == modelData ? Colors.workspaceButtonMainBorder : Colors.workspaceButtonInactiveBorder
            PText {
                anchors.fill: parent
                font: Constants.mainFont
                color: Colors.foreground
                text: modelData.name
            }
        }
    }
    Rectangle {
        Layout.fillWidth: true
        color: Colors.background
        implicitHeight: parent.height * 0.2
    }
}

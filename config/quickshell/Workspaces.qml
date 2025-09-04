import QtQuick
import QtQuick.Layouts
import "components"
import "config"

RowLayout {
    spacing: Constants.borderHeight
    Rectangle {
        Layout.fillWidth: true
        color: Colors.background
        implicitHeight: parent.height * 0.2
    }
    Repeater {
        model: WM.workspaces
        Rectangle {
            required property var modelData
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: height
            Layout.maximumWidth: height * 2
            color: modelData.focused ? Colors.workspaceButtonMain : Colors.workspaceButtonInactive
            border.width: Constants.borderHeight
            border.color: modelData.focused ? Colors.workspaceButtonMainBorder : Colors.workspaceButtonInactiveBorder
            PIcon {
                visible: !!modelData.icon
                anchors.fill: parent
                anchors.margins: Constants.borderHeight * 1.5
                name: modelData.icon
            }
            PText {
                visible: !modelData.icon
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

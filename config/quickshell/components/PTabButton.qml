import QtQuick
import QtQuick.Controls
import "../config"

TabButton {
    id: button

    property var palette: Colors.buttonPalette
    property var backgroundColor: palette.backgroundIdle
    property var borderColor: palette.borderIdle
    padding: Constants.borderHeight * 2.0
    font: Constants.mainFont
    property bool active: button.pressed
    property bool lighted: button.hovered || TabBar.index == TabBar.tabBar.currentIndex
    implicitHeight: font.pixelSize * 1.5

    contentItem: PText {
        text: button.text
        font: button.font
        color: Colors.foreground
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        color: button.backgroundColor
        border.color: button.borderColor
        border.width: Constants.borderHeight
    }
    transitions: Transition {
        ColorAnimation {
            properties: "backgroundColor,borderColor"
            duration: Constants.buttonAnimationDuration
        }
    }
    states: [
        State {
            name: "active"
            when: button.active
            PropertyChanges {
                target: button
                backgroundColor: button.palette.backgroundPress
                borderColor: button.palette.borderPress
            }
        },
        State {
            name: "hovered"
            when: !button.active && button.lighted
            PropertyChanges {
                target: button
                backgroundColor: button.palette.backgroundHover
                borderColor: button.palette.borderHover
            }
        }
    ]
}

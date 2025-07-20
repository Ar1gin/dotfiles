pragma Singleton

import QtQml
import QtQuick
import "../components"

QtObject {
    readonly property color none: "#00000000"
    readonly property color background: "#2A2A37"
    readonly property color elementBackground: "#16161D"
    readonly property color foreground: "#C5C9C5"
    readonly property color foregroundDim: foreground.darker(2)
    readonly property color border: "#54546D"
    readonly property color barShadow: "#16161D"
    readonly property color textShadow: Colors.elementBackground

    readonly property color workspaceButtonMain: "#54546D"
    readonly property color workspaceButtonMainBorder: "#957fb8"
    readonly property color workspaceButtonActive: "#2A2A37"
    readonly property color workspaceButtonActiveBorder: "#404058"
    readonly property color workspaceButtonInactive: "#2A2A37"
    readonly property color workspaceButtonInactiveBorder: "#363646"

    readonly property color panelBorder: "#363646"
    readonly property color panelBackground: "#16161D"

    readonly property color clockBarNoon: "#836F4A"
    readonly property color clockBarNoonBorder: "#F9D791"
    // readonly property color clockBarEvening: "#43436C"
    // readonly property color clockBarEveningBorder: "#5D57A3"
    // readonly property color clockBarNight: "#C84053"
    // readonly property color clockBarNightBorder: "#E46876"
    readonly property color clockText: "#FFFFFF"

    readonly property color musicBar: "#8081D7"

    readonly property color indicatorAlert: "#C84053"
    readonly property color indicatorAlertBorder: "#FF5D62"
    readonly property color indicatorAlertText: "#DCD7BA"

    readonly property color indicatorRam: "#ED5051"

    readonly property color indicatorMic: "#5CA662"
    readonly property color indicatorSpeaker: "#529EB8"

    readonly property color indicatorBattery: "#DEAE3E"

    readonly property var buttonPalette: ButtonPalette {
        backgroundIdle: "#2A2A37"
        borderIdle: "#363646"
        backgroundHover: Colors.workspaceButtonActive
        borderHover: Colors.workspaceButtonActiveBorder
        backgroundPress: Colors.workspaceButtonMain
        borderPress: Colors.workspaceButtonMainBorder
    }
    readonly property var buttonPaletteAlert: ButtonPalette {
        backgroundIdle: "#C84053"
        borderIdle: "#FF5D62"
        backgroundHover: Qt.lighter(backgroundIdle, 1.25)
        borderHover: Qt.lighter(borderIdle, 1.25)
        backgroundPress: Qt.lighter(backgroundHover, 1.25)
        borderPress: Qt.lighter(borderHover, 1.25)
    }
}

pragma Singleton
import Quickshell
import QtCore

Singleton {
    id: scratchpad
    property var text
    Settings {
        property alias text: scratchpad.text
    }
}

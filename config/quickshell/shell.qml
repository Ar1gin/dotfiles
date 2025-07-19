import Quickshell
import Quickshell.Io
import QtQuick

ShellRoot {
    Variants {
        model: Quickshell.screens
        Bar {
            property var modelData
            screen: modelData
        }
    }
}

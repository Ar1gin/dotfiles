import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"
import "../config"

ColumnLayout {
    id: panel

    spacing: Constants.borderHeight

    property int index: bar.currentIndex

    TabBar {
        id: bar
        Layout.fillWidth: true
        spacing: Constants.borderHeight
        PTabButton {
            text: "Scratchpad"
        }
    }
    StackLayout {
        currentIndex: bar.currentIndex
        Scratchpad {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        // TODO:
        // - [ ] System monitor
        // - [ ] Controls
        // - [ ] Runner
    }
}

import QtQuick
import QtQuick.Controls
import "../config"

Rectangle {
    border.width: Constants.borderHeight
    border.color: Colors.panelBorder
    color: Colors.panelBackground
    ScrollView {
        anchors.fill: parent
        TextArea {
            id: area
            text: PersistentScratchpad.text
            onTextEdited: PersistentScratchpad.text = area.text
        }
    }
}

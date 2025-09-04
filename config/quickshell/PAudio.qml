import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "components"
import "config"

Rectangle {
    id: audio
    required property var node
    required property color activeColor
    required property string activeText
    required property string inactiveText

    property bool active: (links.linkGroups.length > 0) && (audio.node.audio != null) && (!audio.node.audio.muted) && (audio.node.audio.volume > 0)

    color: border.color.darker(1.75)
    border.width: Constants.borderHeight
    border.color: active ? activeColor : Colors.workspaceButtonActiveBorder

    PText {
        anchors.fill: parent
        color: Colors.foreground
        font: Constants.tinyFont
        text: audio.active ? (links.linkGroups.length > 1 ? links.linkGroups.length + " " + audio.activeText : audio.activeText) : audio.inactiveText
    }
    PwObjectTracker { objects: [audio.node] }
    PwNodeLinkTracker { id: links; node: audio.node}
}

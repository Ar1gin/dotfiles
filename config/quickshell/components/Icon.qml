import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

Item {
    id: icon
    required property string path
    property color color: "#ffffff"

    implicitWidth: image.implicitWidth
    implicitHeight: image.implicitHeight
    Image {
        id: image
        anchors.fill: parent
        source: Quickshell.iconPath(icon.path)
        layer.enabled: icon.color != "#ffffff"
        layer.effect: MultiEffect {
            colorization: 1
            colorizationColor: icon.color
        }
        opacity: icon.color.a
        fillMode: Image.PreserveAspectFit
    }
}
